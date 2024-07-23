### Set the repository and ISO download link
$RepositoryURL  = '(Replace with RAW repository URL)'
$ISOURL         = '(Replace with direct ISO download URL)'

### Search OSDCloud and WinPE partitions
$disk       = Get-WMIObject Win32_Volume | Where-Object { $_.Label -eq 'OSDCloudUSB' }
$disk       = $disk.Name
$diskwinpe  = Get-WMIObject Win32_Volume | Where-Object { $_.Label -eq 'WinPE' }
$diskwinpe  = $diskwinpe.Name

### Getting version from GitHub .\Update\Version.txt and .\Update\VersionWinPE.txt
$version        = Invoke-WebRequest -Uri "$RepositoryURL/Update/Version.txt"
$version        = $version.Content.Split([Environment]::NewLine) | Select-Object -First 1
$versionWinPE   = Invoke-WebRequest -Uri $RepositoryURL/Update/VersionWinPE.txt
$versionWinPE   = $versionWinPE.Content.Split([Environment]::NewLine) | Select-Object -First 1

### Setting file names and locations
$downloadspath  = (New-Object -ComObject Shell.Application).Namespace('shell:Downloads').Self.Path
$file           = "Version.txt"
$fileWinPE      = "VersionWinPE.txt"
$folder         = 'OSDCloud\'
$location       = "$disk$folder"

### Getting versions from USB drive
$versionondisk      = Get-Content "$location$file" -ErrorAction SilentlyContinue
$versionWinPEondisk = Get-Content "$location$fileWinPE" -ErrorAction SilentlyContinue

### Install OSDCloud module if not present
if (Test-Path -Path "$env:ProgramFiles\WindowsPowerShell\Modules\OSD") {
    Write-Host " OSDCloud Module already installed"
} else {
    Clear-Host
    Write-Host " ***************************"
    Write-Host " *      OSDCloud Menu      *"
    Write-Host " ***************************"
    Write-Host
    Write-Host " Installing OSDCloud Module"
    Write-Host
    Install-Module OSD -force
}

$MainMenu = {
    Write-Host " ***************************"
    Write-Host " *      OSDCloud Menu      *"
    Write-Host " ***************************"
    Write-Host
    Write-Host " 1.) OSDCloud Local (WinPE)"
    Write-Host " 2.) Install/Update OSDCloudUSB (Windows)"
    Write-Host " Q.) Exit Powershell"
    Write-Host
    Write-Host " Select an option and press Enter: "  -nonewline
}
Clear-Host
Do {
    Clear-Host
    Invoke-Command $MainMenu
    $Select = Read-Host
    Switch ($Select)
        {
        1 {
            Invoke-WebPSScript $RepositoryURL/OSDCloudStartAndUpdate.ps1
        }
        2 {
            Invoke-WebPSScript $RepositoryURL/OSDCloudUpdateMenu.ps1
        }
        Q {
            Exit
        }
    }
}
While ($Select -ne "Z")
