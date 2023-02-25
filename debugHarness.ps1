$ModPath = gi 'H:\data\2023\pwsh\PsModules\Nancy\Output\Nancy'
$PSStyle.OutputRendering = 'Ansi'
# if ('usingModuleBuilder' -and $false) {
#     Import-Module -Name (Join-Path $PSScriptRoot 'Release\Nancy') -Force
#     '<display welcome gradient>'
# }
# else {

#     Import-Module -Name (Join-Path $PSScriptRoot 'module') -Force
# }
Import-Module $ModPath -Force

Get-Command -m Nancy
| Sort-Object CommandType, Name
| Format-Table Name -GroupBy CommandType

'see also: "https://github.com/PoshCode/Pansies/blob/main/Source/Private/_init.ps1"'
