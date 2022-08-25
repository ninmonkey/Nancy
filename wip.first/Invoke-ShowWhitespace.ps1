using namespace System.Collections.Generic

$Paths = @{
    Rules  = Get-Item -ea stop (Join-Path $PSScriptRoot 'rules-indented.basics.psd1')
    Global = Get-Item 'C:\Users\cppmo_000\skydrive\Documents\2021\dotfiles_git\powershell\PSScriptAnalyzerSettings.psd1'
}

# to get around formatter stripping the test file
$StrSpaces = ' ' * 4 | Join-String
$Sample = @{}


$Sample.Basic = @"
if(`$true) { $StrSpaces
    'stuff' $StrSpaces
}
"@

$Expected = @{} + @{
    Basic = $Sample.Basic -split '\r?\n' -replace '\s+$' -join "`n"
}

function _colorizeChar {
    <#
    .SYNOPSIS
        wraps text with color, and reset color
    .EXAMPLE
        _colorizeChar 'hi world'
    #>
    param( [string]$Text )
    @(
        "${bg:gray25}"
        "${fg:green}"
        $Text
        # "${bg:clear}"
        # "${fg:clear}"
        $PSStyle.Reset
    ) -join ''
}

function showWhitespace {
    <#
    .SYNOPSIS
        different ways to visualize whitespace in text
    .EXAMPLE

    #>
    [cmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]$InputText,

        [ValidateSet('SpaceOnly', 'AllWhitespace', 'FormatControl', 'Default')]
        [Parameter()]$OutputMode = 'SpaceOnly'
    )
    begin {
        [list[string]]$Lines = @()
    }
    process {
        $Lines.Add( $InputText )
    }
    end {
        $Content = $Lines | Join-String -sep "`n"

        switch ($OutputMode) {
            'SpaceOnly' {
                $Content -replace ' ', { _colorizeChar $_ }
                # ($Lines | Join-String -sep "`n") -replace ' ', { _colorizeChar $_ }

            }
            'AllWhitespace' {
                $Content -replace '\s', {
                    _colorizeChar $_
                }

            }
            'FormatControl' {
                $Content -replace '\s', {
                    $str = $_ | Format-ControlChar
                    _colorizeChar $str
                }
            }
            default {
                $content | Format-ControlChar
            }
        }
    }
}
hr -fg orange
$Sample.Basic -replace ' ', { _colorizeChar $_ }

h1 'showWhitespace-v2'

Label 'Mode' 'Default'
$Sample.Basic
| showWhitespace -OutputMode 'Default'

Label 'Mode' 'AllWhitespace' -before 2 -af 1
$Sample.Basic
| showWhitespace -OutputMode AllWhitespace

Label 'Mode' 'FormatControl' -before 2 -af 1
$Sample.Basic
| showWhitespace -OutputMode FormatControl

Label 'Mode' 'SpaceOnly'
$Sample.Basic
| showWhitespace -OutputMode SpaceOnly


hr 2
h1 'showWhitespace-v1'


$scriptContent = @'
if($true) {
    'stuff'
}
'@

# Invoke-Formatter -ScriptDefinition $($scriptContent -join "`n") -Settings $RuleConfig | Write-ConsoleColorZd -BackgroundColor 'gray20' -Fg black

h1 '$sample.Basic | showWhitespace' -fg magenta
$sample.Basic | showWhitespace

h1 '$Expected.Basic | showWhitespace' -fg magenta
$Expected.Basic | showWhitespace

