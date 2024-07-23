Clear-host
Write-Host " ***************************"
Write-Host " *   Upload OSDCloud ISO   *"
Write-Host " ***************************"
Write-Host

### Check if AZCopy is installed
if (-NOT ((Test-Path -path $env:APPDATA\AzCopy\azcopy.exe -PathType Leaf)) {
    ### Installing AzCopy
    Write-Host " Installing AZCopy"
    Write-Host
    Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile "$downloadspath\AzCopy.zip" -UseBasicParsing
    Expand-Archive "$downloadspath\AzCopy.zip" "$downloadspath\AzCopy" -Force
    mkdir $env:APPDATA\AzCopy
    Get-ChildItem "$downloadspath\AzCopy\*\azcopy.exe" | Move-Item -Destination $env:APPDATA\AzCopy\
    Remove-Item -Force "$downloadspath\AzCopy.zip"
    Remove-Item -Force -Recurse "$downloadspath\AzCopy\"
} Else {

}
Write-Host " Make sure the ISO location/name = $downloadspath\OSDCloud_NoPrompt.iso"
Write-Host
cmd /c 'pause'

### Starting the AzCopy action to upload the file
Write-Host " Uploading OSDCloud ISO to cloud storage"
Invoke-Expression "& '$env:APPDATA\AzCopy\azcopy.exe' login"
try {
    Invoke-Expression  "& '$env:APPDATA\AzCopy\azcopy.exe' copy '$downloadspath\OSDCloud_NoPrompt.iso' $ISOURL" -ErrorAction SilentlyContinue | Out-Null
} catch {
    Write-Host " Upload failed, error massage:"
    Write-Host
    Write-host "$error" -ForegroundColor red
    Write-Host
    cmd /c 'pause'
}
