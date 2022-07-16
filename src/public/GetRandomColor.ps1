function Get-RandomNancyColor {
    <#
    .synopsis
        random 24bit color
    .DESCRIPTION
        Output is raw random, no smoothing.
    .EXAMPLE
        Pwsh> Get-RandomNancyColor
        Pwsh> Get-RandomNancyColor -Count 10
    #>
    [Alias('Nancy->RandColor')]
    [OutputType('PoshCode.Pansies.RgbColor')]
    [CmdletBinding()]
    param(
        # Return more than one color
        [Alias('Count')][int]$TotalCount = 1
    )

    foreach ($i in 1..$TotalCount) {
        $r, $g, $b = Get-Random -Count 3 -Minimum 0 -Maximum 255
        [PoshCode.Pansies.RgbColor]::new($r, $g, $b)
    }
}