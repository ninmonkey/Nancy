## Checklist

- [ ] [plat shields](https://learn.microsoft.com/en-us/powershell/scripting/gallery/concepts/publishing-guidelines?view=powershell-7.4#tag-your-package-with-the-compatible-pseditions-and-platforms)
- [ ] custom [`PSScriptAnalyzer` rules / skeleton](https://learn.microsoft.com/en-us/powershell/scripting/gallery/concepts/publishing-guidelines?view=powershell-7.3#use-psscriptanalyzer)
- [ ] enable building in <file:///Nancy.build.ps1>
  - [ ] `-Jobs AssertDevDependencies, Clean, BuildDll, CopyToRelease, BuildDocs`
  - [ ] `BuildDocs`
  - [ ] `Publish`
  - [ ] `Clean`
  - [ ] `Platypus`
  - [ ] `Pester`
  - [ ] `CopyToRelease`
  - [ ] `DoTest`
  - [ ] any `*.cs`

- [ ] [module manifest metadata](https://learn.microsoft.com/en-us/powershell/scripting/gallery/concepts/package-manifest-affecting-ui?view=powershell-7.3)
- [ ] [SemVar](https://learn.microsoft.com/en-us/powershell/scripting/gallery/concepts/publishing-guidelines?view=powershell-7.3#best-practices-for-publishing-packages)
- [ ] some other module that replaces PowershellGet ? 
## Code

- [what's new in Pwsh Docs](https://learn.microsoft.com/en-us/powershell/scripting/community/2023-updates?view=powershell-7.4)
- [ ] [`PSCustomTableHeaderLabelDecoration` new in 7.4](https://learn.microsoft.com/en-us/powershell/scripting/learn/experimental-features?view=powershell-7.3#pscustomtableheaderlabeldecoration)
- [ ] [PSStyle `.dim` and `.dimOff`](https://github.com/PowerShell/PowerShell/pull/18653)

## Other stuff 

- [ ] [Get-Command -FuzzyMinimumDistance](https://github.com/PowerShell/PowerShell/pull/18261)
- [ ] [PSFeedback Provider](https://learn.microsoft.com/en-us/powershell/scripting/learn/experimental-features?view=powershell-7.4#psfeedbackprovider)
- [ ] [PSModuleAutoLoadSkipOffline](https://learn.microsoft.com/en-us/powershell/scripting/learn/experimental-features?view=powershell-7.4#psmoduleautoloadskipofflinefiles)
