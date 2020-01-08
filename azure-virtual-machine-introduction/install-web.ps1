Add-WindowsFeature Web-Server
Add-Content `
    -Path "C:\inetpub\wwwroot\Default.htm" `
    -Value "Hello World from $($env:computername)"