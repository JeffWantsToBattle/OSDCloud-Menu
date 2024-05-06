#Custom variables
$version = "V1.0"

#Search OSDCloud disk
$disk = Get-WMIObject Win32_Volume | ? { $_.Label -eq 'OSDCloudUSB' }
$disk = $disk.Name

if ($disk -eq "") {
    Write-host "OSDCloud niet gevonden"
    cmd /c 'pause'
} else {
    #Check version
    $file = "versie.txt"
    $versioncheck = Get-Content $disk$file -ErrorAction SilentlyContinue

    if ($versioncheck -eq $version){
        Write-host "OSDCloud is up-to-date"
        cmd /c 'pause'
    } else {
        Write-host "updating OSDCloud"

        #Write new version
        New-Item -Path $disk -Name "versie.txt" -ItemType "file" -Value $versie -Force
    }
}
