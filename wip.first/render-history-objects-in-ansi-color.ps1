

function Get-HistoryCommandOffset {
    <#
    .synopsis
        paste the nth item from history, negative for revese index
    .EXAMPLE
        PS> PasteHistory -4     # returns 4 oldest command
    #>
    [Alias('PasteHistory')]
    param(
        [Parameter(Mandatory, Position = 0)]
        [int]$HistoryOffset
    )

    Get-History
    | Sort-Object Id -Descending
    | at $HistoryOffset
}


# $histCache ??= Get-History | Format-List

# todo
# Skip duplicate items, ideelly keep order
Get-History | Group-Object CommandLine | Where-Object Count -GT 1 | s -First 5

# Using 'PadRight/Left' both [1] aligns our strings, and, [2], ensures substring is does not have an index error
$Colors = @{
    TypeName    = $PSStyle.Foreground.FromRgb('#4974a1')
    MemberName  = $PSStyle.Foreground.FromRgb('#a4dcff')
    MemberValue = $PSStyle.Foreground.FromRgb('#dbdc9a')
}
$Target = $PRofile
$target | IterProp | Join-String -sep "`n" -op "`n" { @(
        $max = 20
        $Colors.TypeName
        $_.TypeNameOfValue.ToString().padright($max).substring(0, $max)
        ' '
        $Colors.MemberName
        $_.name.ToString().Padright( $max).Substring(0, $max)
        ' '
        $Colors.MemberValue
        $_.Value.ToString().padright($max + 20).substring(0, $max + 20)
        ' '
    ) -join ''
}

function _renderHistSummary_singleLine.proto {
    [OutputType('System.String')]
    [CmdletBinding()]
    param(
        [AllowNull()]
        [Alias('InputObject')]
        [Parameter(Mandatory, ValueFromPipeline)]
        $HistoryObject
    )
    begin {
        $render = @{}
        $meta = @{}
    }
    process {
        if ($null -eq $HistoryObject) {
            return
        }


        if ( $HistoryObject.ExecutionStatus -eq ([Runspaces.PipelineState]::Completed) ) {
            $Meta.ExecutionStatus = ' '
        } else {
            $Meta.ExecutionStatus = '!'
        }
        # $histCache | ForEach-Object {
        $render.Duration = '{0:n2}s' -f @(
            $_.Duration.TotalSeconds
        ) -join ''

        $render.ExecutionStatus = $Meta.ExecutionStatus

        $render.Command1Line = $HistoryObject.CommandLine -replace '\r?\n', '␠'
        | shortStr -HeadCount 20 -TailCount 20

        $fullRender = @(
            $render.ExecutionStatus
            $render.Duration
            $render.Command1Line
        ) -join ''
        return $fullRender
    }
}


function _renderHistSummary_multiLine {
    <#
    .SYNOPSIS
        Register-ArgumentCompleter 'Copy-HistoryCmd.proto'
    #>
    [OutputType('System.String')]
    [CmdletBinding()]
    param(
        # [para]
    )

}

h1 'history'

Get-History | Get-Random -Count 8
| _renderHistSummary_singleLine.proto



# (Get-History | ForEach-Object CommandLine) | shortStr -HeadCount 30 -TailCount 10
Function Copy-HistoryCmd.proto {

    [CmdletBinding(SupportsShouldProcess)]
    [alias('ch')]
    [outputtype('None', 'System.String')]
    Param(
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [int[]]$ID = $(Get-History).Count,
        [switch]$Passthru)

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {
        $idString = $id -join ','
        Write-Verbose "[PROCESS] Getting commandline from history item: $idstring"
        $cmdstring = (Get-History -Id $($id)).CommandLine
        If ($PSCmdlet.ShouldProcess("ID #$idstring")) {
            $cmdstring | Microsoft.PowerShell.Management\Set-Clipboard

            If ($Passthru) {
                #write the command to the pipeline
                $cmdstring
            } #If passthru
        }
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end

} #close function


Register-ArgumentCompleter -CommandName Copy-HistoryCmd.proto -ParameterName Id -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    Get-History
    | Where-Object { $_.id -like "$wordtocomplete*" }
    | Select-Object -Last 10 -First 20
    | ForEach-Object {
        # completion text,listitem text,result type,Tooltip
        [System.Management.Automation.CompletionResult]::new($_.id, $_.id, 'ParameterValue', $_.commandline)
    }
}



# Register-ArgumentCompleter -CommandName Copy-HistoryCmd.proto -ParameterName Id -ScriptBlock {
#     param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
#     $Config.MaxItems = 40

#     Get-History
#     | Select-Object -Last 10 -First $Config.MaxItems
#     | Where-Object { $_.id -like "$wordtocomplete*" } |
#     ForEach-Object {
#         # completion text,listitem text,result type,Tooltip
#         [System.Management.Automation.CompletionResult]::new($_.id, $_.id, 'ParameterValue', $_.commandline)
#     }
# }