CLS
###Custom variables
$version = "V1.0"

###Search OSDCloud disk
$disk = Get-WMIObject Win32_Volume | ? { $_.Label -eq 'OSDCloudUSB' }
$disk = $disk.Name

Write-Host " ***************************"
Write-Host " *     OSDCloud Update     *"
Write-Host " ***************************"
Write-Host

if ($disk -eq $null) {
    Write-host " OSDCloudUSB drive not found" -ForegroundColor Red
    cmd /c 'pause'
} else {
    Write-host " OSDCloudUSB drive found" -ForegroundColor Green
    ###Check version
    $file = "Version.txt"
    $folder = 'OSDCloud\'
    $location = "$disk$folder"
    $versioncheck = Get-Content "$location$file" -ErrorAction SilentlyContinue
    if ($versioncheck -eq $version){
        Write-host " OSDCloudUSB already up-to-date" -ForegroundColor Green
        Write-Host
        cmd /c 'pause'
    } else {
        Write-host " Updating OSDCloudUSB" -ForegroundColor Green
        ###Write new version
        New-Item -Path $location -Name "$file" -ItemType "file" -Value $version -Force
        #Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/file1 -OutFile .\file1
        #Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/file2 -OutFile .\file2
        Write-host " Updating compleet" -ForegroundColor Green
        Write-Host
        cmd /c 'pause'

    }
}
