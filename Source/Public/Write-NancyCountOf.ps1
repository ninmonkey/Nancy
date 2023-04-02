function Write-NancyCountOf {
    <#
    .SYNOPSIS
        Count the number of items in the pipeline, ie: @( $x ).count
    .EXAMPLE
        ,@('a'..'e' + 0..3) | CountIt -Out-Null
        @('a'..'e' + 0..3) | CountIt -Out-Null

        # outputs
        1 items
        9 items
    #>
    # [CmdletBinding()]
    # [Alias('Len', 'Len🧛‍♀️')] # warning this breaks crrent parameter sets
    [Alias('CountOf', 'Len',
        '🧛‍♀️.Of' # puns are fun
    )]
    param(
        [switch]$Extra,

        # Also consume output (pipe to null)
        [switch]${Out-Null}
    )
    begin {
        [int]$totalCount = 0
        [COllections.Generic.List[Object]]$Items = @()
    }
    process { $Items.Add( $_ ) }
    end {
        if ( ${out-Null}.IsPresent) {
            $items | Out-Null # redundant?
        }
        else {
            $items
        }
        $colorBG = $PSStyle.Background.FromRgb('#362b1f')
        $colorFg = $PSStyle.Foreground.FromRgb('#e5701c')
        $colorFg = $PSStyle.Foreground.FromRgb('#f2962d')
        @(
            $ColorFg
            $ColorBg
            '{0} items' -f @(
                $items.Count
            )
            $PSStyle.Reset
            # $PSStyle.Foreground.FromRgb('#e5701c')
            "${fg:gray60}"
            if ($Extra) {
                ' {0} of {1}' -f @(
                    ($Items)?.GetType().Name ?? "[`u{2400}]"
                    # $Items.GetType().Name ?? ''
                    # @($Items)[0].GetType().Name ?? ''
                    @($Items)[0]?.GetType() ?? "[`u{2400}]"
                )
            }
            $PSStyle.Reset
        ) -join ''
        | Write-Information -infa 'Continue'


    }
}
