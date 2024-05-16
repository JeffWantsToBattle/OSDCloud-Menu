###Search OSDCloud disk
$disk = Get-WMIObject Win32_Volume | Where-Object { $_.Label -eq 'OSDCloudUSB' }
$disk = $disk.Name

###Getting version from .\Update\VersionWinPE.txt
$versionWinPE = Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/VersionWinPE.txt
$versionWinPE = $versionWinPE.Content.Split([Environment]::NewLine) | Select -First 1

###Getting version from OSDCloudUSB drive
$file = "VersionWinPE.txt"
$folder = 'OSDCloud\'
$location = "$disk$folder"
$versionWinPEondisk = Get-Content "$location$file" -ErrorAction SilentlyContinue


$MainMenu = {
Write-Host " ***************************"
Write-Host " * WinPE Update or Install *"
Write-Host " ***************************"
Write-Host
Write-Host " WinPE version " -nonewline
    if ($versionWinPEondisk -lt $versionWinPE) {
        Write-Host "$versionWinPEondisk " -nonewline -ForegroundColor Red
        Write-Host "found on $disk"
    } else {
        Write-Host "$versionWinPEondisk " -nonewline -ForegroundColor green
        Write-Host "found on $disk"
    }
Write-Host
Write-Host " 1.) Start update/install"
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
           New-OSDCloudUSB -fromIsoFile https://jvdosd.blob.core.windows.net/bootimage/OSDCloud_NoPrompt.iso
        }
    }
}
While ($Select -ne "Q")
