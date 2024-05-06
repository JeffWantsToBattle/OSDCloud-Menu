#Custom variables
$version = "V1.0"

#Search OSDCloud disk
$disk = Get-WMIObject Win32_Volume | ? { $_.Label -eq 'OSDCloudUSB' }
$disk = $disk.Name

if ($disk -eq $null) {
    Write-host "OSDCloudUSB drive not found"
} else {
    Write-host "OSDCloudUS drive found"
    #Check version
    $file = "Version.txt"
    $folder = 'OSDCloud\'
    $location = "$disk$folder"
    $versioncheck = Get-Content "$location$file" -ErrorAction SilentlyContinue
    if ($versioncheck -eq $version){
        Write-host "OSDCloud is up-to-date"
    } else {
        Write-host "Updating OSDCloud"
        #Write new version
        New-Item -Path $location -Name "Version.txt" -ItemType "file" -Value $versie -Force
    }
}
