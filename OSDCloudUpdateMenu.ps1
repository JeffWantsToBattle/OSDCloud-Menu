###Intro formatting
Clear-Host
Write-Host " ***************************"
Write-Host " *   OSDCloud Update menu  *"
Write-Host " ***************************"
Write-Host

###Search OSDCloud disk
$disk = Get-WMIObject Win32_Volume | Where-Object { $_.Label -eq 'OSDCloudUSB' }
$disk = $disk.Name

###Getting version from .\Update\Version.txt
$version = Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/Version.txt
$version = $version.Content.Split([Environment]::NewLine) | Select -First 1

###Getting version from OSDCloudUSB drive
$file = "Version.txt"
$folder = 'OSDCloud\'
$location = "$disk$folder"
$versionondisk = Get-Content "$location$file" -ErrorAction SilentlyContinue

###Check if OSDCloudUSB drive is found
if ($disk -eq $null) {
    Write-host " OSDCloudUSB drive not found" -ForegroundColor Red
    Write-host " Check that the partition name matches: OSDCloudUSB" -ForegroundColor Red
    Write-Host
    cmd /c 'pause'
} else {
    Clear-Host
    $MainMenu = {
    Write-Host " ***************************"
    Write-Host " *   OSDCloud Update menu  *"
    Write-Host " ***************************"
    Write-Host " OSDCloud version $versionondisk found on $disk" -nonewline
    if ($versionondisk -lt $version) {
        Write-Host "$versionondisk" -nonewline -ForegroundColor Red
        Write "found on $disk"
    } else {
        Write-Host "$versionondisk" -nonewline -ForegroundColor green
        Write "found on $disk"
    }
    Write-Host " 1.) Update OSDCloudUSB to version $version"
    Write-Host " 2.) Update WinPE < not ready"
    Write-Host " 3.) Update Powershell scripts"
    Write-Host " 4.) Download Windows 11 23H2 Retail"
    Write-Host " 5.) Download Drivers (Menu)"
    Write-Host " Q.) Back"
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
            Invoke-WebPSScript 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/OSDCloudOSDUpdate.ps1'
        }
        2 {
            #New-OSDCloudUSB -fromIsoUrl "Blob URL"
        }
        3 {
            Update-OSDCloudUSB -PSUpdate
        }
        4 {
            Update-OSDCloudUSB -OSName "Windows 11 23H2" -OSLanguage nl-nl -OSLicense Retail
        }
        5 {
            Invoke-WebPSScript 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/OSDCloudDriverDownload.ps1'
        }
        }
    }
    While ($Select -ne "Q")
}
