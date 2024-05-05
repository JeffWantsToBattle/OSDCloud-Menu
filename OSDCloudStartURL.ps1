$MainMenu = {
Write-Host " ***************************"
Write-Host " *         OSDCloud        *"
Write-Host " ***************************"
Write-Host
Write-Host " 1.) OSDCloud local"
Write-Host " 2.) OSDCloud Azure"
Write-Host " 3.) OSDCloud AZure Sandbox"
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
