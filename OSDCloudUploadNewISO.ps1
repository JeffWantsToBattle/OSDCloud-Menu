$DownloadsPath = (New-Object -ComObject Shell.Application).Namespace('shell:Downloads').Self.Path
    Write-Host " ***************************"
    Write-Host " *   OSDCloud ISO Upload   *"
    Write-Host " ***************************"
    Write-Host


if (Test-Path -path $env:APPDATA\AzCopy\azcopy.exe -PathType Leaf){
    ### Starting the AzCopy action < test file = Test.txt
    Invoke-Expression "& '$env:APPDATA\AzCopy\azcopy.exe' login"
    try {
    Invoke-Expression  "& '$env:APPDATA\AzCopy\azcopy.exe' copy '$DownloadsPath\Test.txt' https://jvdosd.blob.core.windows.net/bootimage/Test.txt" -ErrorAction SilentlyContinue | Out-Null
    } catch {
        Write-Host " Error"
        cmd /c 'pause'
    }
} Else {
    ### Install AzCopy
    Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile AzCopy.zip -UseBasicParsing
    Expand-Archive ./AzCopy.zip ./AzCopy -Force
    mkdir $env:APPDATA\AzCopy
    Get-ChildItem ./AzCopy/*/azcopy.exe | Move-Item -Destination $env:APPDATA\AzCopy\
    Remove-Item -Force AzCopy.zip
    Remove-Item -Force -Recurse .\AzCopy\
    # Rerun the script from start?
}