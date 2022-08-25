$Color = @{
    Bright_Text = @(
        $PSStyle.background.FromRgb(220, 220, 220)
        $PSStyle.foreground.FromRgb(40, 40, 40)
    ) -join ''
    Dim_Text    = @(
        # $PSStyle.background.FromRgb(170, 170, 170)
        $PSStyle.foreground.FromRgb(120, 120, 120)
    ) -join ''
    Reset       = $PSStyle.Reset
}

function wrapStr {
    [OutputType('String')]
    param(
        $Color,
        $Text,
        $strPrefix = '<',
        $strSuffix = '>'
    )
    return @(
        $Color
        $StrPrefix
        '{0}' -f $Text
        $StrSuffix
        $Color.Reset
    ) -join ''
}
function Format-NullText {
    param(
        [AllowNull()]
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputText)
    begin {}
    process {
        if ($InputText.Count -eq 0 -and $InputText -is 'array') {
            wrapStr $Color.Dim_Text '@()'
        }
        if ($null -eq $InputText) {
            wrapStr $Color.Dim_Text '␀'
            return
        }
        if ($InputText -is 'string' -and $InputText.Length -eq 0) {
            wrapStr $Color.Dim_Text 'Str Empty'
            return
        }
        if ([string]::IsNullOrWhiteSpace($InputText)) {
            wrapStr $Color.Dim_Text 'Blank'
            return
        }
        return $InputText # actually returns [object]
    }
}


@(
    [list[object]]::new()
    $l

    [list[object]]$l = 'a'..'e'
    $l


    ''
    ' '
    $Null
    , @()
    @()
    @($Null)
    , @($Null)
)
| Format-NullText

@(
    [list[object]]::new()
    $l

    [list[object]]$l = 'a'..'e'
    $l
)