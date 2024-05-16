###Intro formatting
Clear-Host
Write-Host " ***************************"
Write-Host " *    Update OSDCloudUSB   *"
Write-Host " ***************************"
Write-Host

###Getting version from .\Update\Version.txt
$version = Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/Version.txt
$version = $version.Content.Split([Environment]::NewLine) | Select -First 1

###Search OSDCloud disk
$disk = Get-WMIObject Win32_Volume | Where-Object { $_.Label -eq 'OSDCloudUSB' }
$disk = $disk.Name

###Check if OSDCloudUSB drive is found
if ($disk -eq $null) {
    Write-host " OSDCloudUSB drive not found" -ForegroundColor Red
    Write-host " Check that the partition name matches: OSDCloudUSB" -ForegroundColor Red
    Write-Host
    cmd /c 'pause'
} else {
    ###Getting version from OSDCloudUSB drive
    $file = "Version.txt"
    $folder = 'OSDCloud\'
    $location = "$disk$folder"
    $versionondisk = Get-Content "$location$file" -ErrorAction SilentlyContinue
    ###Version check
    if ($versionondisk -eq $version){
        Write-host " OSDCloudUSB already updated to version $version" -ForegroundColor Green
        Write-Host
        cmd /c 'pause'
    } else {
        Write-host " Updating OSDCloudUSB to version $version" -ForegroundColor Green
        ###Write new version + error handeling
        try {
            Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/Automate/Start-OSDCloudGUI.json -OutFile $location\Automate\Start-OSDCloudGUI.json
        } catch {
            Write-host " An error occurred: $($_.Exception.Message)" -ForegroundColor Red
            $error1 = 1
        }
        if ($error1 -eq "1"){
            Write-Host
            cmd /c 'pause'
        } else {
            New-Item -Path $location -Name "$file" -ItemType "file" -Value $version -Force | Out-Null
            Write-host " Updating compleet to version $version" -ForegroundColor Green
            Write-Host
            cmd /c 'pause'
        }
    }
}
