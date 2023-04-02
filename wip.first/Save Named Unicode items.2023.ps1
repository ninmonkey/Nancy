@'
Structure similar to Irregular\Get-Regex

save named sequences like


'@ | Write-Warning

function nancy.Rune.GetDistinctValues {
    <#
    .SYNOPSIS
        return the distinct list of all runes based on codepoints
    .EXAMPLE

    PS>
        '▸·⇢⁞ ┐⇽▂🖥️🏷️🗃️📁📦⁞🐛💻▸⇢📄📁⁞ ┐⇽▂🏠🖧delim·DevTool💻 Conversion📏 Style🎨 Format🎨 ArgCompleter🧙‍♂️ NativeApp💻 ExamplesRef📚 TextProcessing📚 Regex🔍 Prompt💻 Cli_Interactive🖐 Experimental🧪 UnderPublic🕵️‍♀️ My🐒 Validation🕵to.collect.🐝.txt - nin.todo.🐒.txt➙🠚▸·⇢⁞ ┐⇽▂↦[]≠∈⇒'
        |
        | nancy.Rune.GetDistinctValues
    #outputs:
        -.ACDEFIMNPRSTUV[]_abcdefgilmnoprstuvxy·‍⁞↦⇒⇢⇽∈≠┐▂▸♀♂➙️🎨🏠🏷🐒🐛🐝💻📁📄📏📚📦🔍🕵🖐🖥🖧🗃🠚🧙🧪
    #>
    [OutputType('System.String')]
    param()
    process {
        return $_.EnumerateRunes()
        | Sort-Object { $_.Value } -Unique
        | Join-String
    }
}

@(
    @{
        GroupName = 'TOC'
        Items     = @(
            @{
                Rune           = '🧛'
                Name           = '<actualUnicodeName>'
                Tags           = 'Vampire', 'Count', 'Dracula'
                # and automatic tag: 'Emoji'
                # dynamically calcualte
                GraphemeLength = 1 # I forget the dotnet name
                UnicodeLength  = 1
                CharLength     = '🧛'.Length
                # ContainsMale ?
                # Contains Zwj Sequences
            }
            @{
                Rune = '▸·⇢⁞ ┐⇽▂🖥️🏷️🗃️📁📦⁞🐛💻▸⇢📄📁⁞ ┐⇽▂🏠🖧delim·DevTool💻 Conversion📏 Style🎨 Format🎨 ArgCompleter🧙‍♂️ NativeApp💻 ExamplesRef📚 TextProcessing📚 Regex🔍 Prompt💻 Cli_Interactive🖐 Experimental🧪 UnderPublic🕵️‍♀️ My🐒 Validation🕵to.collect.🐝.txt - nin.todo.🐒.txt➙🠚▸·⇢⁞ ┐⇽▂↦[]≠∈⇒'
                Name = 'DumpForLater'
                Tags = 'Dump', 'Buffer'
                # and automatic tag: 'Emoji'
                # dynamically calcualte
                # GraphemeLength = 1 # I forget the dotnet name
                # UnicodeLength  = 1
                # CharLength     = '🧛'.Length
                # ContainsMale ?
                # Contains Zwj Sequences
            }
        )
    }
    @{
        GroupName = 'Separators'
        Items     = @(
            @{
                Runes          = '▸·⇢⁞ ┐⇽▂🖥️🏷️🗃️📁📦⁞🐛💻▸⇢📄📁⁞ ┐⇽▂🏠🖧delim·DevTool💻 Conversion📏 Style🎨 Format🎨 ArgCompleter🧙‍♂️ NativeApp💻 ExamplesRef📚 TextProcessing📚 Regex🔍 Prompt💻 Cli_Interactive🖐 Experimental🧪 UnderPublic🕵️‍♀️ My🐒 Validation🕵to.collect.🐝.txt - nin.todo.🐒.txt➙🠚▸·⇢⁞ ┐⇽▂↦[]≠∈⇒'
                Name           = 'Common Delimiters'
                Tags           = 'Delimiters', 'Separator'
                # and automatic tag: 'Emoji'
                # dynamically calcualte
                GraphemeLength = 1 # I forget the dotnet name
                UnicodeLength  = 1
                # CharLength     = '🧛'.Length
                # ContainsMale ?
                # Contains Zwj Sequences
            }
            @{
                Rune           = '▸·⇢⁞ ┐⇽▂🖥️🏷️🗃️📁📦⁞🐛💻▸⇢📄📁⁞ ┐⇽▂🏠🖧delim·DevTool💻 Conversion📏 Style🎨 Format🎨 ArgCompleter🧙‍♂️ NativeApp💻 ExamplesRef📚 TextProcessing📚 Regex🔍 Prompt💻 Cli_Interactive🖐 Experimental🧪 UnderPublic🕵️‍♀️ My🐒 Validation🕵to.collect.🐝.txt - nin.todo.🐒.txt➙🠚▸·⇢⁞ ┐⇽▂↦[]≠∈⇒'
                Name           = '<actualUnicodeName>'
                Tags           = 'Vampire', 'Count', 'Dracula'
                # and automatic tag: 'Emoji'
                # dynamically calcualte
                GraphemeLength = 1 # I forget the dotnet name
                UnicodeLength  = 1
                CharLength     = '🧛'.Length
                # ContainsMale ?
                # Contains Zwj Sequences
            }
        )
    }
)