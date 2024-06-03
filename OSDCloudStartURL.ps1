### Set the repository and ISO download link
$GitHubURL = 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main'
$BlobISO = 'https://jvdosd.blob.core.windows.net/bootimage/OSDCloud_NoPrompt.iso'

### Install OSDCloud module if not present
#if (Get-InstalledModule -Name OSD) { < Get-InstalledModule can be slow so replaced with Test-Path, need to test in WinPE
if (Test-Path -Path "$env:ProgramFiles\WindowsPowerShell\Modules\OSD") {
    Write-Host " OSDCloud Module already installed"
} else {
    Clear-Host
    Write-Host " ***************************"
    Write-Host " *      OSDCloud Menu      *"
    Write-Host " ***************************"
    Write-Host
    Write-Host " Installing OSDCloud Module"
    Write-Host
    Install-Module OSD -force
}

$MainMenu = {
    Write-Host " ***************************"
    Write-Host " *      OSDCloud Menu      *"
    Write-Host " ***************************"
    Write-Host
    Write-Host " 1.) OSDCloud Local (WinPE)"
    Write-Host " 2.) OSDCloud Azure (WinPE)"
    Write-Host " 3.) OSDCloud Azure Sandbox (WinPE)"
    Write-Host " 4.) Install/Update OSDCloudUSB (Windows)"
    Write-Host " 5.) Autopilot (Windows)"
    Write-Host " Q.) Exit Powershell"
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
            Invoke-WebPSScript $GitHubURL/OSDCloudUpdateMenu.ps1
        }
        5 {
            Clear-Host
            Write-Host " ***************************"
            Write-Host " *         Autopilot       *"
            Write-Host " ***************************"
            Write-Host
            Write-Host " A login window will open, login with an Autopilot authorized user account"
            Write-Host
            try {
                Get-WindowsAutopilotInfo.ps1 -online
            } Catch {
                Write-Host "Autopilot script not found, installing script"
                install-script -Name Get-WindowsAutoPilotInfo -Force
                Get-WindowsAutopilotInfo.ps1 -online
            }
        }
        Q {
            Exit
        }
    }
}
While ($Select -ne "Z")
