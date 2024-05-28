Write-Host " ***************************"
Write-Host " *   OSDCloud ISO Maker    *"
Write-Host " ***************************"
Write-Host

$downloadsPath = (New-Object -ComObject Shell.Application).Namespace('shell:Downloads').Self.Path
$ADKURL = 'https://go.microsoft.com/fwlink/?linkid=2271337'
$ADKAddonURL = 'https://go.microsoft.com/fwlink/?linkid=2271338'

### Install Windows ADK
if (-Not (get-package | where Name -Like "Windows Assessment and Deployment Kit")) {
    Write-host " Installing Windows ADK"
    Invoke-WebRequest $ADKURL -outfile $downloadsPath\adksetup.exe)
    Start-Process -NoNewWindow -FilePath "$downloadsPath\adksetup.exe" -ArgumentList "/quiet /features OptionId.DeploymentTools /norestart"
} else {
    Write-host " Windows ADK already installed"
}

### Install Windows ADK add-on
if (-Not (get-package | where Name -Like "Windows Assessment and Deployment Kit Windows Preinstallation Environment Add-ons")) {
    Invoke-WebRequest $ADKAddonURL -outfile $downloadsPath\adkwinpesetup.exe)
    Start-Process -NoNewWindow -FilePath "$downloadsPath\adkwinpesetup.exe" -ArgumentList "/quiet /norestart"
    Write-host " Installing Windows ADK add-on"
} else {
    Write-host " Windows ADK add-on already installed"
}

### Starting OSDCloud configuration
### Creating OSDCloud Workspace
$LocOSDWorkspace = "C:\OSDCloud"
if (-Not (Get-OSDCloudWorkspace)) {
    Write-host " Making new OSDCloud Template/Workspace"
    New-OSDCloudTemplate
    New-OSDCloudWorkspace "$LocOSDWorkspace"
    $WorkspaceLoc = Get-OSDCloudWorkspace
    Write-host " Workspace created, location: $WorkspaceLoc"
} else {
    $WorkspaceLoc = Get-OSDCloudWorkspace
    Write-host " OSDCloud Workspace already set up, location: $WorkspaceLoc "
}

### Ready WinPE
Edit-OSDCloudWinPE -CloudDriver *
Edit-OSDCloudWinPE -StartURL $GitHubURL/OSDCloudStartURL.ps1
Copy-Item "$LocOSDWorkspace\OSDCloud_NoPrompt.iso" -Destination "$downloadsPath"
Write-host " OSDCloud ISO created and copied to $downloadsPath"

$MainMenu = {
    Write-Host " ***************************"
    Write-Host " *   OSDCloud ISO Maker    *"
    Write-Host " ***************************"
    Write-Host
    Write-Host " 1.) Upload ISO to Azure Blob < Not ready"
    Write-Host " 2.) Cleanup\Uninstall OSDCloud Workspace"
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
            Invoke-WebPSScript $GitHubURL/OSDCloudUploadNewISO.ps1
        }
        2 {
            Write-Host
            Write-Host " Option not ready"
            Write-Host
            cmd /c 'pause'
        }
        Q {
            Invoke-WebPSScript $GitHubURL/OSDCloudUpdateMenu.ps1
        }
    }
}
While ($Select -ne "Z")