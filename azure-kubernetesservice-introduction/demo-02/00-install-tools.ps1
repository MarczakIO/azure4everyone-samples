Set-ExecutionPolicy Unrestricted -Force
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco install git --yes
choco install docker-desktop --yes
choco install docker-compose --yes
choco install vscode --yes
choco install azure-cli --yes
choco install googlechrome --yes
