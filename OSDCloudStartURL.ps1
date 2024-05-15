#set-disres 1600
$MainMenu = {
Write-Host " ***************************"
Write-Host " *         OSDCloud        *"
Write-Host " ***************************"
Write-Host
Write-Host " 1.) OSDCloud Local"
Write-Host " 2.) OSDCloud Azure"
Write-Host " 3.) OSDCloud Azure Sandbox"
Write-Host " 4.) Update OSDCloudUSB"
Write-Host " 5.) Download Windows 11 23H2 Retail"
Write-Host " 6.) Download Drivers Menu"
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
        Invoke-WebPSScript 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/OSDCloudOSDUpdate.ps1'
    }
    5 {
        Update-OSDCloudUSB -OSName "Windows 11 23H2" -OSLanguage nl-nl -OSLicense Retail
    }
    6 {
        Invoke-WebPSScript 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/OSDCloudDriverDownload.ps1'
    }
#Add Autopilot?
#Add Update-OSDCloudUSB -PSUpdate
#Add update WinPE (New-OSDCloudUSB -fromIsoUrl ) < werkt mogelijk niet in WinPE maar wel in Windows.
    }
}
While ($Select -ne "Q")
