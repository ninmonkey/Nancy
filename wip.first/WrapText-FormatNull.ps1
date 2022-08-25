# $p = Start-Process -FilePath TabularEditor.exe -Wait -NoNewWindow -PassThru -ArgumentList '/?'
@'
see full code
    H:\data\2022\powerbi\invokeTabular.ps1
'@


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
        $Text
    )
    return @(
        $Color
        '{0}' -f $Text
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
        if ($null -eq $InputText) {
            return @(
                $Color.Dim_Text
                # '<␀>'
                '<True ␀>'
                $Color.Reset
            ) -join ''
        }
        if ($InputText -is 'string' -and $InputText.Length -eq 0) {
            return @(
                $Color.Dim_Text
                # '[string]::Empty'
                '<Str Empty>'
                $Color.Reset
            ) -join ''
        }
        if ([string]::IsNullOrWhiteSpace($InputText)) {
            return @(
                $Color.Dim_Text
                '<Str Blank>'
                $Color.Reset
            ) -join ''
        }
        return $InputText # actually returns [object]
    }
}

$null | Format-NullText
@(
    ''
    ' '
    $Null
    , @()
    @()
    @($Null)
    , @($Null)
)
| Format-NullText