function _nancyShowWhiteSpace {
    <#
    .synopsis
        quickly view whitespace
    .description
        warning, does not handle cases where patterns collide
        using color per single char could fix that, making regex pattern matching
        be ' {1}' not ' {1,}'
    .NOTES
        future:
            - treat tabs, spaces, as different
            - replace nulls and coontrol chars with symbols
            - different whitespace different colors
    .DESCRIPTION
        the original was
            $manOut -replace '\s+', { @( $PSStyle.Background.FromRgb(80, 80, 80); $_; $PSStyle.Reset ) -join '' }
    #>
    [CmdletBinding()]
    [Alias('nanSpace')]
    param(
        [Alias('Text')]
        [Parameter(Mandatory)]
        [string[]]$InputText,
        $Options = @{}
    )
    $Config = ninmonkey.console\Join-Hashtable -OtherHash $Options -BaseHash @{
        MergeBeforeWork = $true
        Color           = @{
            BG_Space        = $PSStyle.Background.FromRgb(80, 80, 80)
            BG_SpaceLiteral = $PSStyle.Background.FromRgb(80, 80, 180)
            BG_Tab          = $PSStyle.Background.FromRgb(180, 80, 80)
        }
        ReplaceBG       = @{
            # SpaceLiteral = $True
            # Space        = $True # wildcard
            # Tab          = $True
            SpaceLiteral = $False
            Space        = $False # wildcard
            Tab          = $true
        }
        Regex           = @{
            Space        = ' +'
            SpaceLiteral = '[ ]+'
            Tab          = '\t+'
        }
        RegexSingle     = @{
            Space        = ' '
            SpaceLiteral = '[ ]'
            Tab          = '\t'
        }
    }
    $Accum = $InputText

    $Accum += "hi world`n`tsdf`n`nblash`tblash`t`tblah"


    if ($Config.MergeBeforeWork) {
        $Accum = $Accum -join "`n"
    }
    if ($COnfig.ReplaceBG.Tab) {
        $accum = $accum -replace '\t+', { @(
                $Config.Color.BG_Tab
                $_
                $PSStyle.Reset
            ) -join '' }
    }
    if ($COnfig.ReplaceBG.SpaceLiteral) {
        $accum = $accum -replace '[ ]+', { @(
                $Config.Color.BG_SpaceLiteral
                $_
                $PSStyle.Reset
            ) -join '' }
    }
    if ($COnfig.ReplaceBG.Space) {
        $accum = $accum -replace '\s+', { @(
                $Config.Color.BG_Space
                $_
                $PSStyle.Reset
            ) -join '' }
    }
    return $Accum
}
$invokeId += 1

h1 ($InvokeId++)
h1 ($InvokeId++)
h1 ($InvokeId++)
h1 ($InvokeId++)
h1 ($InvokeId++)
h1 ($InvokeId++)
h1 ($InvokeId++)
nanSpace $ManOut

h1 ($InvokeId++)
nanSpace $manOut -Options @{ ReplaceBG = @{ Space = $false; SpaceLiteral = $true } }
