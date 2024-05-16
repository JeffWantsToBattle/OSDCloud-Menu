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
$versionondisk = Get-Content "$location$file" -ErrorAction SilentlyContinue

$MainMenu = {
Write-Host " ***************************"
Write-Host " * WinPE Update or Install *"
Write-Host " ***************************"
Write-Host
Write-Host " WinPE version " -nonewline
    if ($versionondisk -lt $version) {
        Write-Host "$versionondisk " -nonewline -ForegroundColor Red
        Write-Host "found on $disk"
    } else {
        Write-Host "$versionondisk " -nonewline -ForegroundColor green
        Write-Host "found on $disk"
    }
Write-Host " 1.) "
Write-Host " 2.) "
Write-Host " 3.) "
Write-Host " 4.) "
Write-Host " 5.) "
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
        Start-OSDCloudGUI
    }
    2 {
        Start-OSDCloudAzure
    }
    3 {
        iex (irm az.osdcloud.com)
    }
    4 {
        Clear-Host
        try {
            Get-WindowsAutopilotInfo.ps1 -online
        } Catch {
            Clear-Host
            Write-Host " ***************************"
            Write-Host " *         OSDCloud        *"
            Write-Host " ***************************"
            Write-Host
            Write-Host "Autopilot script not found, installing script"
            install-script -Name Get-WindowsAutoPilotInfo -force
            Write-Host "Executing Autopilot script"
            Get-WindowsAutopilotInfo.ps1 -online
        }
    }
    5 {
        Invoke-WebPSScript 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/OSDCloudUpdateMenu.ps1'
    }
    }
}
While ($Select -ne "Q")

















###Check if OSDCloudUSB drive is found
if ($disk -eq $null) {
    Write-host " OSDCloudUSB drive not found" -ForegroundColor Red
    Write-host " Check that the partition name matches: OSDCloudUSB" -ForegroundColor Red
    Write-Host
    cmd /c 'pause'
} else {
    ###Getting version from OSDCloudUSB drive
    $file = "VersionWinPE.txt"
    $folder = 'OSDCloud\'
    $location = "$disk$folder"
    $versionondisk = Get-Content "$location$file" -ErrorAction SilentlyContinue
    ###Version check
    if ($versionondisk -eq $versionWinPE){
        Write-host " OSDCloudUSB already updated to version $versionWinPE" -ForegroundColor Green
        Write-Host
        cmd /c 'pause'
    } else {
        Write-host " Updating WinPE" -ForegroundColor Green
        ###Write new version + error handeling
        try {
            New-OSDCloudUSB -fromIsoUrl "https://jvdosd.blob.core.windows.net/bootimage/OSDCloud_NoPrompt.iso"
        } catch {
            Write-host " An error occurred: $($_.Exception.Message)" -ForegroundColor Red
            $error1 = 1
        }
        if ($error1 -eq "1"){
            Write-Host
            cmd /c 'pause'
        } else {
            New-Item -Path $location -Name "$file" -ItemType "file" -Value $version -Force | Out-Null
            Write-host " Updating compleet to version $versionWinPE" -ForegroundColor Green
            Write-Host
            cmd /c 'pause'
        }
    }
}
