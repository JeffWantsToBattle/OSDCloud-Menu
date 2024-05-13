###Custom variables
$version = "V1.0"

###Version check thats not working > adds enter add the end of the file
#$version2 = Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/Version.txt
#$version2 = $version2.Content

###Search OSDCloud disk
$disk = Get-WMIObject Win32_Volume | Where-Object { $_.Label -eq 'OSDCloudUSB' }
$disk = $disk.Name

###Intro formatting
Clear-Host
Write-Host " ***************************"
Write-Host " *     OSDCloud Update     *"
Write-Host " ***************************"
Write-Host

###Check if OSDCloudUSB drive is found
if ($disk -eq $null) {
    Write-host " OSDCloudUSB drive not found" -ForegroundColor Red
    Write-host " Check that the partition name matches: OSDCloudUSB" -ForegroundColor Red
    Write-Host
    cmd /c 'pause'
} else {
    Write-host " OSDCloudUSB drive found on $disk" -ForegroundColor Green
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
        New-Item -Path $location -Name "$file" -ItemType "file" -Value $version -Force | Out-Null
        #Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/Automate/Start-OSDCloudGUI.json -OutFile $location\Automate\Start-OSDCloudGUI.json
        #Invoke-WebRequest -Uri https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/Version.txt -OutFile $location\Version.txt
#Need to add try/catch error
        Write-host " Updating compleet" -ForegroundColor Green
        Write-Host
        cmd /c 'pause'
    }
}
