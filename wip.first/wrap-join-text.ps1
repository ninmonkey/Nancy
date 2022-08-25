Join-Regex -Regex @(
    Join-Regex -Text ('Developer/Engineer/Programmer' -split '/') | Join-String -os '?'
    Join-Regex -Text ('Senior/Junior/Professional/Expert' -split '/') | Join-String -os '?'
)

Join-Regex -Text ('Developer/Engineer/Programmer' -split '/') | Join-String -op '(' -os ')?'


$optSegment = @{
    OutputPrefix = '('
    OutputSuffix = ')?'
}
$optGroup = @{
    OutputPrefix = '(', '?<Name>' -join ''
    OutputSuffix = ')?'
}
function wrapTextBasic {
    param(
        [Parameter(ValueFromPipeline)]
        [string]$InputText,

        [Alias('op')]
        [Parameter(Position = 0)]
        [string]$Prefix,

        [Alias('os')]
        [Parameter(Position = 1)]
        [string]$Suffix
    )
    process {
        $Prefix ??= '('
        $Suffix ??= ')'
        @(
            '('
            $InputText
            ')'
        ) -join ''
    }
}
enum WrapStyle {
    Under
    RegexOptional
    RegexNamedGroup
}
function wrapText {
    param(
        [Parameter(ValueFromPipeline)]
        [string]$InputText,

        [Alias('op')]
        [Parameter(Position = 0)]
        [string]$Prefix,

        [Alias('os')]
        [Parameter(Position = 1)]
        [string]$Suffix,

        # some support args
        [Parameter()]
        [string]$Argumment1,

        # maybe param 1?
        [Parameter()]
        [WrapStyle]$Style
    )
    begin {
        if ( $Null -eq $Prefix ) {
            $Prefix = '('
        }
        if ( $Null -eq $Suffix) {
            $Suffix = ')'
        }
        switch ($Style) {
            ([WrapStyle]::Under) {
                $Prefix = '_'
                $Suffix = ''
            }
            ([WrapStyle]::RegexOptional) {
                $Prefix = '('
                $Suffix = '?)'
            }
            ([WrapStyle]::RegexNamedGroup) {
                $Prefix = @(
                    '(?<'
                    $Argument1 ?? 'Name'
                    '>'
                ) -join ''
                $Suffix = ')'
            }
            default {

            }
        }
    }
    process {
        @(
            $Prefix
            $InputText
            $Suffix
        ) -join ''
    }
}

H1 'header'
$StyleList | UL | Label 'enum [WrapStyle]'
$StyleList = [WrapStyle] | Get-EnumInfo | ForEach-Object name | Sort-Object

H1 'invoke without args'
H1 -fg purple '---- unwrap'
Label 'Type' 'No args, no join'
Label 'Code' ' .. | wrapText'
$StyleList | ForEach-Object {
    $Style = [WrapStyle]$_
    'a'..'c' | wrapText -style $Style
}

H1 -fg purple '---- none'
H1 -fg purple '---- unwrap'
$StyleList | ForEach-Object {
    $Style = [WrapStyle]$_
    Label '[WrapStyle]::' $Style -sep ''
    'a'..'c' | wrapText -style $Style | UL
}

function newGroup {
    param(

        [Parameter(ValueFromPipeline)]
        [string]$InputText
    )
    '(?<Name>'
    $InputText
    ')'
}

Join-Regex -Text ('Developer/Engineer/Programmer' -split '/') | Join-String @optSegment
Join-Regex -Text ('Developer/Engineer/Programmer' -split '/') | Join-String @optSegment
Join-Regex -Text ('Developer/Engineer/Programmer' -split '/') | Join-String @optGroup