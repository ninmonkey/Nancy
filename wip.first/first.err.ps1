  function err {
   param( [switch]$Clear )
   if($Clear) { $global:error.Clear()  }
   return $global:error
}