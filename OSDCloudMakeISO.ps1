Write-Host " ***************************"
Write-Host " *   OSDCloud ISO Maker    *"
Write-Host " ***************************"
Write-Host

### Install Windows ADK
if (-Not (get-package | where Name -Like "Windows Assessment and Deployment Kit")) {
    Write-host " Installing Windows ADK"
    # Download adksetup.exe
    $ .\adksetup.exe /quiet /norestart /features OptionId.DeploymentTools /norestart
    #or: Start-Process -NoNewWindow -FilePath ".\adksetup.exe" -ArgumentList "/quiet /installpath "C:\Program Files\ADK" /features OptionId.DeploymentTools /norestart"
} else {
    Write-host " Windows ADK already installed"
}

### Install Windows ADK add-on
if (-Not (get-package | where Name -Like "Windows Assessment and Deployment Kit Windows Preinstallation Environment Add-ons")) {
    # Download adkwinpesetup.exe
    $ .\adkwinpesetup.exe /quiet /norestart
    # or: Start-Process -NoNewWindow -FilePath ".\adkwinpesetup.exe" -ArgumentList "/quiet /norestart"
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
    New-OSDCloudWorkspace ($LocOSDWorkspace)
    $WorkspaceLoc = Get-OSDCloudWorkspace
    Write-host " Workspace created, location: $WorkspaceLoc"
} else {
    $WorkspaceLoc = Get-OSDCloudWorkspace
    Write-host " OSDCloud Workspace already set up, location: $WorkspaceLoc "
}

### Ready WinPE
Edit-OSDCloudWinPE -CloudDriver *
Edit-OSDCloudWinPE -StartURL $GitHubURL/OSDCloudStartURL.ps1
$downloadsPath = (New-Object -ComObject Shell.Application).Namespace('shell:Downloads').Self.Path
copy "$LocOSDWorkspace\OSDCloud_NoPrompt.iso" "$downloadsPath"
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