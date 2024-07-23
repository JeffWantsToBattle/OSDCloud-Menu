Clear-Host
$MainMenu = {
    Write-Host " ***************************"
    Write-Host " *  OSDCloud Update Menu   *"
    Write-Host " ***************************"
    Write-Host
    
    ### Check if OSDCloudUSB drive is found
    if ($disk -eq $null) {
        ### Menu if disk is not found
        Write-host " OSDCloudUSB drive not found" -ForegroundColor Red
        Write-host " Check that the partition name matches: OSDCloudUSB" -ForegroundColor Red
        Write-Host
        Write-Host " 1.) Install OSDCloudUSB" -nonewline
        Write-Host " $versionWinPE" -ForegroundColor green
        Write-Host " 3.) Make new OSDCloud ISO"
        Write-Host " 4.) Upload ISO (Downloads\OSDCloud_NoPrompt.iso)"
        Write-Host " Q.) Back"
        Write-Host
        Write-Host " Select an option and press Enter: "  -nonewline
    } else {
        Write-Host " OSDCloudUSB " -nonewline
        ### Check if OSDCloudUSB version is lower then new version
        if ($versionondisk -lt $version) {
            Write-Host "$versionondisk " -nonewline -ForegroundColor Red
            Write-Host "found on $disk"
        } else {
            Write-Host "$versionondisk " -nonewline -ForegroundColor green
            Write-Host "found on $disk"
        }
        Write-Host " WinPE " -nonewline
        ### Check if WinPE version is lower then new version
        if ($versionWinPEondisk -lt $versionWinPE) {
            Write-Host "$versionWinPEondisk " -nonewline -ForegroundColor Red
            Write-Host "found on $diskwinpe"
        } else {
            Write-Host "$versionWinPEondisk " -nonewline -ForegroundColor green
            Write-Host "found on $diskwinpe"
        }
        ### Menu if disk is found
        Write-Host
        Write-Host " 1.) Install OSDCloudUSB" -nonewline
        Write-Host " $versionWinPE" -ForegroundColor green
        Write-Host " 2.) Update OSDCloudUSB config file" -nonewline
        Write-Host " $version" -ForegroundColor green
        Write-Host " 3.) Make new OSDCloud ISO"
        Write-Host " 4.) Upload ISO (Downloads\OSDCloud_NoPrompt.iso)"
        Write-Host " 5.) Download Windows"
        Write-Host " 6.) Download Drivers"
        Write-Host " Q.) Back"
        Write-Host
        Write-Host " Select an option and press Enter: "  -nonewline
    }
}
Clear-Host
Do {
    Clear-Host
    Invoke-Command $MainMenu
    $Select = Read-Host
    Switch ($Select) {
        1 {
            Invoke-WebPSScript $RepositoryURL/OSDCloudInstallWinPE.ps1
        }
        2 {
            Invoke-WebPSScript $RepositoryURL/OSDCloudUSBUpdate.ps1
        }
        3 {
            Invoke-WebPSScript $RepositoryURL/OSDCloudMakeISO.ps1
        }
        4 {
        Invoke-WebPSScript $RepositoryURL/OSDCloudUploadNewISO.ps1
        }
        5 {
            Invoke-WebPSScript $RepositoryURL/OSDCloudDownloadWindows.ps1
        }
        6 {
            Invoke-WebPSScript $RepositoryURL/OSDCloudDownloadDriver.ps1
        }
        Q {
            Invoke-WebPSScript $RepositoryURL/OSDCloudStartURL.ps1
        }
        R {
            Invoke-WebPSScript $RepositoryURL/OSDCloudUpdateMenu.ps1
        }
    }
}
While ($Select -ne "Z")
