throw 'moving'


'public', 'private' | ForEach-Object {
    # Resolve-Path -Path $PSScriptRoot -ChildPath { $_ }
    Resolve-Path (Join-Path $PSScriptRoot $_)
}
| Get-ChildItem -Recurse -File -Filter *.ps1
| ForEach-Object {
    'pansies-> dotsource: "{0}"' -f $_
    | Write-Verbose

    . $_.FullName
}
