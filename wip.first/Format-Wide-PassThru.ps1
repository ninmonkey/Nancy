
function Write-TableInformation {
    <#
    .SYNOPSIS
        it [1] invokes format table and [2] returns original object
    #>
    [OutputType('System.Object[]')]
    [Alias('wti', 'ft2', 'Format-WideObject')]
    # [Alias('fwo', 'Format-WideObject')]
    [CmdletBinding()]
    param(
        # source object
        [Parameter(Mandatory, ValueFromPipeline)]
        [object[]]$InputObject,

        # names to include?
        [Parameter(Mandatory, ValueFromPipeline)]
        [object[]]$Property,

        [Alias('RemoveGrouping')]
        [Parameter()]
        [switch]$Flatten

    )
    begin {
        [list[object]]$Items = @()
    }
    process {
        # $items.AddRange( $InputObject )
        foreach ($Obj in $InputOBject) {
            $items.add($Obj)
        }
    }
    end {
        $ft_splat = @{
            AutoSize = $true
            Wrap     = $true
        }
        # if ($Property) { $ft_splat['Property'] = $Property }
        if ($Flatten) { $ft_splat['Group'] = { $true } }
        $InformationPreference = 'continue'
        # $Items | Format-Table @ft_splat | Out-String | Write-Information
        $Items | Format-Table @ft_splat
        | Format-Default
        | Out-String
        | Write-Information
        $InformationPreference = 'silentlyContinue'

        return $items
    }
}

# $types = Find-Type | s -First 10 | wti
# $types -is 'array'


# Get-Item . | fm
# $ret = Get-ChildItem . | s -First 10 | wti

# Get-Date | wti

# function Write-WideObject {
#     [CmdletBinding()]
#     param()
# }




<#
Better names? name should be?
Format-WidePassThru
Shouldn't be Format because it returns an object
#>


