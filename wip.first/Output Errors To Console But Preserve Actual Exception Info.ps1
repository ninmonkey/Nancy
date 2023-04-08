# remove-module Ninmonkey.Console
# Import-Module Ninmonkey.Console -PassThru -verb
# if(-not(Ninmonkey.Console)) {
#     $Env:Path = @(
#         'H:\data\2023\pwsh\PsModules'
#         $Env:PATH
#     ) | Join-String -sep ([IO.Path]::PathSeparator)
# }

throw @'
    left off
    - [ ] basic just display error as 1 line
    - [ ] super short mode, only outputs 1 cell
        - [ ] inner write-error, uses -ea 'silentlycontinue'.
        - [ ] then error Red block outputs to write-information

'@
function New-DetailsException {
    # silly, experimental custom output while preserving original details
    [Alias('NewError', 'nin.Error.Details')]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [Alias('PSItem', 'ErrorRecord', 'InpuytObject')]
        [object]$InputException,

        [Alias('Message', 'Description')]
        [ArgumentCompletions(
            'BadStuff', '🔴', 'Nomad⧯', 'NonSequitur⧯'
        )][string]$ErrorDetails,


        [hashtable]$Options = @{}
    )

    # $Config = Ninmonkey.Console\MergeHashtable -BaseHash $Options -OtherHash @{
    # $Config = MergeHashtable -BaseHash $Options -OtherHash @{
    @{
        OutPrefix = @(
            "${fg:gray30}${bg:gray60}"
        ) -join ''
        OutSuffix = @(
            $PSStyle.Reset
        ) -join ''
    }

    $renderError = @(
        $Config.OutPrefix
        $ErrorDetails
        $Config.OutSuffix
    ) -join ''
    $InputException.ErrorDetails = $renderError
}



# NewError -InputException $Error[0] -ErrorDetails 'dsf' -Options @{}

'early exit!'
return



try {
    throw 'throw'
} catch {
   $_.ErrorDetails =
   $_.GetType().name | write-host
   write-error $_
}