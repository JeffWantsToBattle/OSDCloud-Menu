$MainMenu = {
Write-Host " ***************************"
Write-Host " *         OSDCloud        *"
Write-Host " ***************************"
Write-Host
Write-Host " 1.) Start-OSDCloudGUI"
Write-Host " 2.) Start-OSDCloudAzure"
Write-Host " 3.) az.osdcloud.com
Write-Host " 4.) Quit"
Write-Host
Write-Host " Select an option and press Enter: "  -nonewline
}
cls
Do {
cls
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
    }
}
While ($Select -ne 4)
