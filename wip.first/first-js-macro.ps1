# quick helpers for the console
$csv = @{ Sep = ', ' }
$ul = @{ Sep = "`n- "; op = "`n- " }
Set-Alias 'js' -Value 'join-string'


'who', 'Steve', 'PowerShell', 'hello', 'goodbye'
| js @ul


'who', 'Steve', 'PowerShell', 'hello', 'goodbye', 'aza'
| Sort-Object { $_[0], $_[-1] }
| js @ul