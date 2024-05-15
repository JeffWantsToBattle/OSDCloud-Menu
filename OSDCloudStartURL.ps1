#set-disres 1600
$MainMenu = {
Write-Host " ***************************"
Write-Host " *         OSDCloud        *"
Write-Host " ***************************"
Write-Host
Write-Host " 1.) OSDCloud Local"
Write-Host " 2.) OSDCloud Azure"
Write-Host " 3.) OSDCloud Azure Sandbox"
Write-Host " 4.) Autopilot"
Write-Host " 5.) Update OSDCloudUSB (Menu)"
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
    try {
        Get-WindowsAutopilotInfo.ps1 -online
    } Catch {
        Clear-Host
        Write-Host " Autopilot script niet gevonden, script downloaden"
        install-script Get-WindowsAutopilotInfo.ps1 -force
        Write-Host " Autopilot script geinstalleerd en wordt uitgevoerd"
        Get-WindowsAutopilotInfo.ps1 -online
        Write-Host " Script uitgevoerd"
        cmd /c 'pause'
    }
    }
    5 {
        Invoke-WebPSScript 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/OSDCloudUpdateMenu.ps1'
    }
    q {
        Invoke-WebPSScript 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/OSDCloudStartURL.ps1'
    }
    }
}
While ($Select -ne "Z")
