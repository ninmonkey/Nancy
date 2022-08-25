Import-Module Pansies -ea stop
[PoshCode.Pansies.RgbColor]::ColorMode = 'Rgb24bit'

function _randBg {
 (Get-ChildItem bg: | Get-Random -Count 1)
}

$share = @{ width = 50 }
$jStr = @{ Property = { $t = New-Text -bg $_ ' '; $t; $t; }; }
$jStr = @{ Property = { $t = New-Text -bg $_ ' '; $t; }; }
$jStrBasic = @{ Property = { { New-Text -bg $_ ' ' } } }
Get-Gradient pink red -ColorSpace Lch @share | Join-String { New-Text -bg $_ ' ' }
Get-Gradient pink red -ColorSpace Hsl | Join-String @jStr


$GradMinimal = @{ Start = 'red' ; end = 'pink' }
$GradExtreme = @{
    Start = '#DB7093' ; End = '#00EE76'
}
$GradRand = @{ Start = (_randBg) ; end = (_randBg) }


$Grad1 | Format-Table -AutoSize
function _compareColorspace {
    param(
        [Parameter()]
        [argumentCompletions('Hsl', 'Lch', 'Rgb', 'Lab', 'Xyz')]
        [string[]]$ColorSpace,

        # a color
        [string]$Start,
        # a color
        [string]$End,

        [hashtable]$Options = @{

        }
    )
    if (-not $ColorSpace) {
        $ColorSpace = 'Hsl', 'Lch', 'Rgb', 'Lab', 'Xyz'
    }

    foreach ($space in $ColorSpace) {
        Get-Gradient @Grad1 -ColorSpace $Space @share | Join-String @jStr
        Get-Gradient @Grad1 -ColorSpace $Space @share | Join-String @jStr
        Get-Gradient @Grad1 -ColorSpace $Space @share | Join-String @jStr
        Get-Gradient @Grad1 -ColorSpace $Space @share | Join-String @jStr
    }
}

@(
    $GradMinimal
    $GradExtreme
    $GradRand
    $Grad1
) | %{
    $colors = @{ Start = $_.start ; End = $_.end }
    h1 $_
    $colors | Ft -auto
    _compareColorSpace @colors
} | Join-String -sep (hr 1)