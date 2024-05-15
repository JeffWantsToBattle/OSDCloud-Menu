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
Write-Host " 5.) Update menu"
Write-Host " Q.) Quit"
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
        Get-WindowsAutopilotInfo.ps1 -online
    }
    5 {
        Invoke-WebPSScript 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/OSDCloudOSDUpdate.ps1'
    }
    }
}
While ($Select -ne "Q")
