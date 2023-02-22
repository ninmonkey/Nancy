if ('usingModuleBuilder' -and $false) {
    Import-Module -Name (Join-Path $PSScriptRoot 'Release\Nancy') -Force
    $PSStyle.OutputRendering = 'Ansi'
    '<display welcome gradient>'
}
else {

    Import-Module -Name (Join-Path $PSScriptRoot 'module') -Force
}

Get-Command -m Nancy
| Sort-Object CommandType, Name
| Format-Table Name -GroupBy CommandType

'see also: "https://github.com/PoshCode/Pansies/blob/main/Source/Private/_init.ps1"'
