#Install OSDCloud module if not present
if (Get-InstalledModule -Name OSD -ErrorAction SilentlyContinue) {
    Import-Module OSD
} else {
    Write-Host " ***************************"
    Write-Host " *         OSDCloud        *"
    Write-Host " ***************************"
    Write-Host
    Write-Host " Installing OSDCloud Module"
    Install-Module OSD -force
}

$MainMenu = {
Write-Host " ***************************"
Write-Host " *         OSDCloud        *"
Write-Host " ***************************"
Write-Host
Write-Host " From WinPE"
Write-Host " 1.) OSDCloud Local"
Write-Host " 2.) OSDCloud Azure"
Write-Host " 3.) OSDCloud Azure Sandbox"
Write-Host
Write-Host " From Windows"
Write-Host " 4.) Autopilot"
Write-Host " 5.) Install/Update OSDCloudUSB"
Write-Host " Q.) Exit Menu"
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
            Write-Host " ***************************"
            Write-Host " *         Autopilot       *"
            Write-Host " ***************************"
            Write-Host
        try {
            Get-WindowsAutopilotInfo.ps1 -online
        } Catch {
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
