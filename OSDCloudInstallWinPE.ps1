Clear-Host
Write-Host " ***************************"
Write-Host " *    WinPE Installation   *"
Write-Host " ***************************"
Write-Host 
Write-Host " Downloading WinPE"
Write-Host
### Starting WinPE install from Azure Blob and writing the necessary files
New-OSDCloudUSB -fromIsoUrl 'https://jvdosd.blob.core.windows.net/bootimage/OSDCloud_NoPrompt.iso'

### Creating files on de OSDCloud drive
New-Item -ItemType Directory -Path $location\Automate -force -ErrorAction SilentlyContinue | Out-Null
Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/Automate/Start-OSDCloudGUI.json -OutFile $location\Automate\Start-OSDCloudGUI.json
Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/Start-Menu.ps1 -OutFile $location\Start-Menu.ps1
New-Item -Path "$location" -Name "$file" -ItemType "file" -Value $version -force -ErrorAction SilentlyContinue | Out-Null
New-Item -Path "$location" -Name "$fileWinPE" -ItemType "file" -Value $versionWinPE -force -ErrorAction SilentlyContinue | Out-Null
New-Item -Path "$disk" -Name "Start-Menu.ps1" -ItemType "file" -Value "Start-Process powershell -Verb runAs "iex (irm osd.jevede.nl)"" -force -ErrorAction SilentlyContinue | Out-Null

$MainMenu = {
    Write-Host " ***************************"
    Write-Host " *    WinPE Installation   *"
    Write-Host " ***************************"
    Write-Host
    Write-Host " WinPE Installation complete"
    Write-Host " Install one more WinPE to a USB drive?"
    Write-Host
    Write-Host " 1.) Yes (insert new USB drive before continuing)"
    Write-Host " 2.) No (delete downloaded ISO)"
    Write-Host " Q.) Back (keeps ISO in Download folder)"
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
            Invoke-WebPSScript 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/OSDCloudInstallWinPE.ps1'
        }
        2 {
            ### Getting the active download folder, Dismounting the image (if mounted) and removing the ISO file
            $ISOPath = (New-Object -ComObject Shell.Application).Namespace('shell:Downloads').Self.Path
            Dismount-DiskImage -ImagePath "$ISOPath\OSDCloud_NoPrompt.iso" -ErrorAction SilentlyContinue | Out-Null
            Remove-Item $ISOPath\OSDCloud_NoPrompt.iso -ErrorAction SilentlyContinue | Out-Null
            Invoke-WebPSScript 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/OSDCloudUpdateMenu.ps1'
        }
        Q {
            Invoke-WebPSScript 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/OSDCloudUpdateMenu.ps1'
        }
    }       
}
While ($Select -ne "Z")
