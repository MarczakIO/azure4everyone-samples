iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco install azure-data-studio --yes