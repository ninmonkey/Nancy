
function Write-NancyBoldText {
    [Alias('write.Bold')]
    [CmdletBinding()]
    <#
    .SYNOPSIS
        sugar, bolded emphasized text in term
    .EXAMPLEd
        write.Bold 'Complete!'
    .EXAMPLE
        # or padded
            'hi'
            write.Bold 'Done!' -af 1 -bef 1
            'hi'
    #>
    param(
        [string]$Text,
        [int]$After,
        [int]$Before
    )
    @(
        if ($Before) {
            "`n" * $Before -join ''
        }
        $Text | New-Text -fg 'Green' -bg 'gray40' | ForEach-Object tostring
        if ($After) {
            "`n" * $After -join ''
        }
    ) -join ''
}
