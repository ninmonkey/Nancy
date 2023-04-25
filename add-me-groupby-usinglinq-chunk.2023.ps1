[int[]] $source = Get-Random -min 0 -Maximum 255 -Count 1000
[System.Linq.Enumerable]::Chunk($source, 16) | %{ 
  $_ | Join-String -sep ' ' -FormatString '{0:x2}'
  }  | Join-String -sep "`n" -f '[{0}]'

