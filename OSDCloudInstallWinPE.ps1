Clear-Host
Write-Host " ***************************"
Write-Host " *    WinPE Installation   *"
Write-Host " ***************************"
Write-Host
New-OSDCloudUSB -fromIsoUrl 'https://jvdosd.blob.core.windows.net/bootimage/OSDCloud_NoPrompt.iso'
New-Item -ItemType Directory -Path $location\Automate | Out-Null
Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/Automate/Start-OSDCloudGUI.json -OutFile $location\Automate\Start-OSDCloudGUI.json
New-Item -Path $location -Name "$file" -ItemType "file" -Value $version -Force | Out-Null
New-Item -Path $location -Name "$fileWinPE" -ItemType "file" -Value $versionWinPE -Force | Out-Null
New-Item -Path $location -Name "Start-Menu.ps1" -ItemType "file" -Value "iex (irm osd.jevede.nl)" -Force | Out-Null

Clear-Host
Write-Host " ***************************"
Write-Host " *    WinPE Installation   *"
Write-Host " ***************************"
Write-Host
Write-Host " WinPE Installation complete"
Write-Host " Install one more USB?"
Write-Host
Write-Host " 1.) Yes"
Write-Host " 2.) No"


#Add unmount ISO file
$ISOPath = (New-Object -ComObject Shell.Application).Namespace('shell:Downloads').Self.Path
Remove-Item $ISOPath\OSDCloud_NoPrompt.iso -ErrorAction SilentlyContinue | Out-Null
