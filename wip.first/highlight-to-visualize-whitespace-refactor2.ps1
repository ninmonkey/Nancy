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
        MergeBeforeWork          = $true
        Regex_UseSingleCharMatch = $false
        Color                    = @{
            BG_Space        = $PSStyle.Background.FromRgb(80, 80, 80)
            BG_SpaceLiteral = $PSStyle.Background.FromRgb(80, 80, 180)
            BG_Tab          = $PSStyle.Background.FromRgb(180, 80, 80)
        }
        ReplaceBG                = @{
            # SpaceLiteral = $True
            # Space        = $True # wildcard
            # Tab          = $True
            SpaceLiteral = $False
            Space        = $true # wildcard
            Tab          = $false
        }
        Regex                    = @{
            Space        = ' +'
            SpaceLiteral = '[ ]+'
            Tab          = '\t+'
        }
        RegexSingle              = @{
            Space        = ' '
            SpaceLiteral = '[ ]'
            Tab          = '\t'
        }
    }

    # temp hard coded
    $Config = Join-Hashtable -BaseHash $Config -OtherHash @{
        ParamBg = @{
            SpaceLiteral = $true
            Space        = $True
            Tab          = $true
        }
    }


    $Accum = $InputText
    if ($Config.Regex_UseSingleCharMatch) {
        $Config.Regex = $Config.RegexSingle
        Write-Debug 'changing regex patterns to single match only'
    }

    if ($Config.MergeBeforeWork) {
        $Accum = $Accum -join "`n"
    }
    if ($COnfig.ReplaceBG.Tab) {
        $accum = $accum -replace $Config.Regex.Tab, { @(
                $Config.Color.BG_Tab
                $_
                $PSStyle.Reset
            ) -join '' }
    }
    if ($COnfig.ReplaceBG.SpaceLiteral) {
        $accum = $accum -replace $COnfig.Regex.SpaceLiteral, { @(
                $Config.Color.BG_SpaceLiteral
                $_
                $PSStyle.Reset
            ) -join '' }
    }
    if ($COnfig.ReplaceBG.Space) {
        $accum = $accum -replace $Config.Regex.Space, { @(
                $Config.Color.BG_Space
                $_
                $PSStyle.Reset
            ) -join '' }
    }
    return $Accum
}
$invokeId += 1
$Sample2 = "hi world`n`tsdf`n`nblash`tblash`t`tblah"

@{ Space = $false; SpaceLiteral = $true } | Format-HashTable SingleLine | Label 'ReplaceBG'
nanSpace $sample2 -Options @{
    ReplaceBG = @{
        Space = $false; SpaceLiteral = $true
    }
}
# ...
hr -fg magenta 0
$paramBG = @{ Space = $true; SpaceLiteral = $true }
$paramBG | Format-HashTable SingleLine | Label 'paramBG' -bef 1
nanSpace $sample2 -Options @{ ReplaceBG = $ParamBg }

$paramBG = @{ Space = $false; SpaceLiteral = $true }
$paramBG | Format-HashTable SingleLine | Label 'paramBG' -bef 1
nanSpace $sample2 -Options @{ ReplaceBG = $ParamBg }

$paramBG = @{
    Space = $True
} # Space = $true }
$paramBG | Format-HashTable SingleLine | Label 'paramBG' -bef 1
nanSpace $sample2 -Options @{ ReplaceBG = $ParamBg;
    Regex_UseSingleCharMatch            = $true
}


$ParamBg = @{
    SpaceLiteral = $true
    Space        = $True
    Tab          = $true
}
$paramBG | Format-HashTable SingleLine | Label 'paramBG' -bef 1
nanSpace $sample2 -Options @{
    Regex_UseSingleCharMatch = $true
    ReplaceBG                = $paramBG
}

return






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
h1 ($InvokeId++)
nanSpace $manOut -Options @{ ReplaceBG = @{ Space = $false; Tab = $true } }

h1 ($InvokeId++)
nanSpace $manOut -Options @{ ReplaceBG = @{ Space = $true; } }
