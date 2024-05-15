$MainMenu = {
Write-Host " ***************************"
Write-Host " *     OSDCloud Driver     *"
Write-Host " ***************************"
Write-Host
Write-Host " 1.) Download HP Drivers"
Write-Host " 2.) Download DELL Drivers"
Write-Host " 3.) Download Lenovo Drivers"
Write-Host " 4.) Download Microsoft Drivers"
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
        Update-OSDCloudUSB -DriverPack HP
    }
    2 {
        Update-OSDCloudUSB -DriverPack Dell
    }
    3 {
        Update-OSDCloudUSB -DriverPack Lenovo
    }
    4 {
        Update-OSDCloudUSB -DriverPack Microsoft
    }
    }
}
While ($Select -ne "Q")
