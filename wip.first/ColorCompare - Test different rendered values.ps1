
function tryColor {
    <#
    .SYNOPSIS
        test a few color variations, to verify vs code terminal config
    .DESCRIPTION

    .EXAMPLE
        # see more:
        [rgbcolor] | Fime *from*
    #>
    [ALias('Nancy.Preview.Colors')]
    [CmdletBinding()]
    param(
        # potential argument variations
        [ArgumentCompletions(
            "'#619db4'",
            '([System.ConsoleColor]::Green)',
            'Green',
            '([RgbColor]0xa86e5a)',
            # puke '#837214'
            "'4bd189'" # expect error for vanilla

        )]
        $color
    )

    [PoshCode.Pansies.RgbColor]::ColorMode
    | Join-String -f '[PoshCode.Pansies.RgbColor]::ColorMode = {0}'
    | Write-Information -infa 'Continue'


    # $stuff = @( $color; ' '; 0..4 ) -join '-'
    $stuff = '-Fore {0} from type: {1}' -f @(
        $Color | Join-String -single
        $Color | Format-ShortTypeName
    )
    # [rgbcolor]'green' | Format-ShortTypeName

    $stuff | Join-String -op 'pansies: ' | Pansies\Write-Host -fore $color
    try {
        $stuff | Join-String -op 'vanilla: ' | Microsoft.PowerShell.Utility\Write-Host -fore $color
    }
    catch {
        $cErr = "${fg:#a86e5a}"
        $_ | Join-String -op 'vanilla: failed: ' | Write-Debug
        $errMsg = ($_.Exception.Message)?.ToString() ?? ''
        $errMsg -split '\.\s+', 2 | Select-Object -First 1
        | Join-String -op "${cErr}vanilla: failed: " -os $PSStyle.Reset
        # | New-Text -fg 'gray50' | Join-String
        | New-Text -fg 'gray50' | Join-String
    }
}
# Hr
# tryColor 'green'
# tryColor 'red'
# tryColor ([System.ConsoleColor]::Green)

Write-Warning 'usage example'
Hr -ExtraLines 1
2
Hr; tryColor '#619db4'
Hr; tryColor 'blue'

Hr; tryColor 'red'
Hr; tryColor ([System.ConsoleColor]::Red)

Hr; tryColor 'green'
Hr; tryColor ([System.ConsoleColor]::Green)

Hr -ExtraLines 1