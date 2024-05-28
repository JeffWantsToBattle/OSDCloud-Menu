### Install Windows ADK
$ .\adksetup.exe /quiet /installpath c:\ADK /features OptionId.DeploymentTools /norestart
#or
Start-Process -NoNewWindow -FilePath ".\adksetup.exe" -ArgumentList "/quiet /installpath c:\ADK /features OptionId.DeploymentTools /norestart"

### Install Windows ADK add-on

