# Nancy | nAnsi | nin-Ansi


## See More

- Examples and TOC links at docs [System.Console\(\)](https://docs.microsoft.com/en-us/dotnet/api/System.Console?view=net-6.0#Streams)

## module Build examples

- [gitversion on commit](https://github.com/PoshCode/ModuleBuilder/blob/main/GitVersion.yml)
- [ClassExplorer/build.ps1](https://github.com/SeeminglyScience/ClassExplorer/blob/master/build.ps1)
- [Module/*.psm1](https://github.com/SeeminglyScience/ClassExplorer/tree/master/module)
- [Indented.Net.IP/build.ps1](https://github.com/indented-automation/Indented.Net.IP/blob/main/build.ps1)

## module builder guidlelines

- 1 function per file
- `FunctionsToExport` is populated by `PublicFilter` to override
- `AliasesToExport` is populated by `[Alias()]` attributes
- `Prerelease` and `ReleaseNotes` in the PSData hashtable in `PrivateData`
- filenames should match function names, that is what public functions are determined by
- you can force load order: "To force classes to be in a certain order, you can prefix their file names with numbers, like `01-User.ps1`"

Examples
- [ClassExplorer build.psd1](https://github.com/SeeminglyScience/ClassExplorer/blob/master/ClassExplorer.build.ps1)
  - [build.yml](https://github.com/SeeminglyScience/ClassExplorer/blob/master/.github/workflows/build.yml)
- [Pansies build.psd1](https://github.com/PoshCode/Pansies/blob/main/build.psd1)