# This  ModuleBuilder, not Invoke-Build

@{
# @{ Path = "Nancy.psd1" }
    # ModuleManifest = ".\Source\Pansies.psd1"
    ModuleManifest = ".\Source\Nancy.psd1"
    # The rest of the paths are relative to the manifest
    OutputDirectory = ".."
    VersionedOutputDirectory = $true
}


# [CmdletBinding()]
# param(
#     [ValidateSet('Debug', 'Release')]
#     [string] $Configuration = 'Release',

#     [Parameter()]
#     [switch] $Force,

#     [Parameter()]
#     [switch] $Publish
# )
# end {
#     # & "$PSScriptRoot\tools\AssertRequiredModule.ps1" InvokeBuild 5.8.4 -Force:$Force.IsPresent
#     $invokeBuildSplat = @{
#         Task = 'PreRelease'
#         File = Join-Path $PSScriptRoot 'Nancy.build.ps1'
#         GenerateCodeCoverage = $true
#         # Force = $Force.IsPresent
#         Configuration = $Configuration
#     }

#     if ($Publish) {
#         $invokeBuildSplat['Task'] = 'Publish'
#     }

#     Invoke-Build @invokeBuildSplat
# }

