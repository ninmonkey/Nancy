Import-Module .\src\Nancy.psm1 -Force -Verbose

Get-Command -m Nancy
| Sort-Object CommandType, Name
| Format-Table Name -GroupBy CommandType