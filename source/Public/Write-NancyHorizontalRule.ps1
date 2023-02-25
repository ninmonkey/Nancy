function Write-NancyHorizontalRule {
    <#
    .SYNOPSIS
        adds a visual break / horizontal line to the console
    .Example
        "line1"; hr; "line2"

    .Example
        "line1"; hr -ExtraLines 3;  "line2"

    #>
    [alias('Hr', 'Fmt->Rule')]
    [cmdletbinding(PositionalBinding = $false
        #,  DefaultParameterSetName = 'NoPipelineInput'
    )]
    param(
        # Number of lines to pad
        [Parameter(Position = 0)]
        [int]$ExtraLines = 0,


        # 'Color as text/hex/rgb (Anything supported by "PoshCode.Pansies.RgbColor"'
        [Parameter()]
        [alias('Fg')]
        [PoshCode.Pansies.RgbColor]$ForegroundColor = 'gray60'

        # # disable color
        # [Parameter()][switch]$NoColor,
        # # number of blank lines before Label
        # [Parameter()]
        # [Alias('Before')]
        # [uint]$LinesBefore = 0,

        # # Number of blank lines after Label
        # [Parameter()]
        # [Alias('After')]
        # [uint]$LinesAfter = 0,
    )
    # $suffix = $prefix = "`n" * $ExtraLines
    begin {
    }
    process {
        $w = $host.ui.RawUI.WindowSize.Width
        $chars = '-' * $w -join ''
        $padding = "`n" * $ExtraLines

        $output = @(
            $padding, $chars, $padding
        ) -join ''

        if ($NoColor) {
            $output
        } else {
            New-Text $output -fg $ForegroundColor
            | ForEach-Object ToString # Do I want to force string here?
        }
    }
    end {
    }
}