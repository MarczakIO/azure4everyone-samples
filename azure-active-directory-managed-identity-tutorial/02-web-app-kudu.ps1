$apiVersion = "2017-09-01"
$resourceURI = "https://vault.azure.net"
$tokenAuthURI = $env:MSI_ENDPOINT + "?resource=$resourceURI&api-version=$apiVersion"
$tokenResponse = Invoke-RestMethod `
  -Method Get `
  -Headers @{"Secret"="$env:MSI_SECRET"; "Content-Type"="application/json"} `
  -Uri $tokenAuthURI `
  -UseBasicParsing
$accessToken = $tokenResponse.access_token
$accessToken

$secretUrl = "https://azuremidemokv.vault.azure.net/secrets/storage-key/"
Invoke-RestMethod `
    -Uri "$($secretUrl)?api-version=7.0" `
    -Method GET `
    -Headers @{Authorization="Bearer $accessToken"}