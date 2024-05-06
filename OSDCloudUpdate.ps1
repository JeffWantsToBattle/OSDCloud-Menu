CLS
###Custom variables
$version = "V1.0"

###Search OSDCloud disk
$disk = Get-WMIObject Win32_Volume | ? { $_.Label -eq 'OSDCloudUSB' }
$disk = $disk.Name

if ($disk -eq $null) {
    Write-host "OSDCloudUSB drive not found"
    cmd /c 'pause'
} else {
    Write-host "OSDCloudUSB drive found"
    ###Check version
    $file = "Version.txt"
    $folder = 'OSDCloud\'
    $location = "$disk$folder"
    $versioncheck = Get-Content "$location$file" -ErrorAction SilentlyContinue
    if ($versioncheck -eq $version){
        Write-host "OSDCloudUSB already up-to-date"
        cmd /c 'pause'
    } else {
        Write-host "Updating OSDCloudUSB"
        ###Write new version
        New-Item -Path $location -Name "$file" -ItemType "file" -Value $version -Force
        #Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/file1 -OutFile .\file1
        #Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/file2 -OutFile .\file2
        Write-host "Updating compleet"
        cmd /c 'pause'

    }
}
