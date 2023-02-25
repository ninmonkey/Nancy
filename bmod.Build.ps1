$splatModule = @{
    Path = "Nancy.psd1"
    # ModuleManifest = ".\Source\Pansies.psd1"
    ModuleManifest = ".\Source\Nancy.psd1"
    # The rest of the paths are relative to the manifest
    # SourcePath = $(Get-Location -PSProvider FileSystem)  # default
    OutputDirectory = "..\Output"
    SourcePath =

    # Semantic version, like 1.0.3-beta01+sha.22c35ffff166f34addc49a3b80e622b543199cc5
    # If the SemVer has metadata (after a +), then the full Semver will be added to the ReleaseNotes
#     # SemVer = ''  # [string]
# -SourceDirectories <String[]>
#     Folders which contain source .ps1 scripts to be concatenated into the module
#     Defaults to Enum, Classes, Private, Public


    PublicFilter = @( # [string[]]
        'Public\*.ps1' # default
    )
    SourceDirectories = @( # concatenated .ps1 scripts
        'Classes'
        'Enums'
        'Private'
        'Public'
    )
    CopyPaths = @()

    Passthru  = $true # returns [moduleInfo\]
# -CopyPaths <String[]>
#     Folders which should be copied intact to the module output
#     Can be relative to the  module folde
    # Version = ''  # [version]
    #   The module version (must be a valid System.Version such as PowerShell supports for modules)
    # default: $(if(($V = $SemVer.Split("+")[0].Split("-",2)[0])){$V})
    # version

    # Prerelase = ''
    # BuildMetaData = @{}
    # If a value is provided here, then the full Semantic version will be inserted to the release notes:
    # Like: ModuleName v(Version(-Prerelease?)+BuildMetadata)
    Encoding = 'UTF8'
<#

    -Target <String>
    Controls whether we delete the output folder and whether we build the output
    There are three options:
      - Clean deletes the build output folder
      - Build builds the module output
      - CleanBuild first deletes the build output folder and then builds the module back into it
    Note that the folder to be deleted is the actual calculated output folder, with the version number
    So for the default OutputDirectory with version 1.2.3, the path to clean is: ..\Output\ModuleName\1.2.3




-IgnoreAliasAttribute [<SwitchParameter>]
    A switch that allows you to disable the update of the AliasesToExport
    By default, (if PublicFilter is not empty, and this is not set)
    Build-Module updates the module manifest FunctionsToExport and AliasesToExport
    with the combination of all the values in [Alias()] attributes on public functions in the module

-Suffix <String>
    The Suffix is either the path to a file (relative to the module folder) or text to put at the bottom of
    the file.
    If the value of Suffix resolves to a file, that file will be read in, otherwise, the value will be used.
    The default is nothing. See examples for more detail

-Prefix <String>
    The prefix is either the path to a file (relative to the module folder) or text to put at the top of the
    file.
    If the value of prefix resolves to a file, that file will be read in, otherwise, the value will be used.
    The default is nothing. See examples for more details.

#>

}

Build-Module @splatModule -verbose -debug
