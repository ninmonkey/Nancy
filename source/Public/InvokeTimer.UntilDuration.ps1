#Requires -Version 7

function renderRandBock {
    <#
    .synopsis
        render a random 24bit color block
    .DESCRIPTION
        Output is random, no smoothing.
    #>
    [OutputType('System.String')]
    [CmdletBinding()]
    param()
    $r, $g, $b = Get-Random -Count 3 -Minimum 0 -Maximum 255
    @(
        # or: [PoshCode.Pansies.RgbColor]::new($r, $g, $b)
        $PSStyle.Background.FromRgb($r, $g, $b)
        ' '
        $PSStyle.Reset
    ) -join ''
}

function InvokeEveryUntilDuration {
    <#
    .SYNOPSIS
        Invoke a script every tick/update, and another on the final invoke
    .EXAMPLE
        InvokeEveryUntilDuration 2000 20 { 'final' } { 'tick' }
    #>
    [Alias('InvokeEvery')]
    param(
        [Parameter(Mandatory)]
        [ArgumentCompletions(20, 40, 200, 500, 2000, 40000)]
        [int]$DelayMs = 2000,

        [Parameter(Mandatory)]
        [ArgumentCompletions(20, 40, 200, 500, 2000, 40000)]
        [int]$SleepSizeMS = 200,

        [Parameter(Mandatory)]
        [Alias('Sb', 'ScriptBlock', 'FinalSB')]
        [ScriptBlock]$AfterDelayScriptBlock,

        #
        [Parameter()]
        [Alias('SBEveryTick')]
        [ScriptBlock]$IntervalScriptBlock
    )

    $delta = [timespan]::new(0, 0, 0, 0, $DelayMs)
    $start = [datetime]::Now
    $target = $start + $delta
    while ($true) {
        $now = [datetime]::Now
        if ( $now -gt $target ) {
            break
        }
        if ($IntervalScriptBlock) {
            & $IntervalScriptBlock
        }
        Start-Sleep -Milliseconds $SleepSizeMS

    }

    & $AfterDelayScriptBlock
}

<#
function __animateEntrance {
    $SbRandBlock = {
        $script:iter++
        if (($iter % 20) -eq 0) {
            ''
        }
        $msg = (renderRandBock)
        [console]::write( $msg )
    }

    InvokeEvery 2000 10 { 'final' } $SbRandBlock
    InvokeEvery 1200 20 { 'final' } {
        $script:iter++
        [Console]::write($iter)
    }
}

#>
