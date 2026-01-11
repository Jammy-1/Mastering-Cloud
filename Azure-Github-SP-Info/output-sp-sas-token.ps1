# Github Repo
$RepoUrl = Read-Host "Enter GitHub repo URL (https://github.com/user/repo)"
$Repo = ($RepoUrl -replace "^https://github.com/", "").TrimEnd("/").TrimEnd(".git")
Write-Host "Repo Detected: $Repo"

# Azure Login
try {
    $account = az account show --output json 2>$null | ConvertFrom-Json
    if (-not $account) { throw "Not Logged In" }
    Write-Host "Azure Login Detected: $($account.user.name)"
} catch {
    Write-Host "Logging Into Azure..."
    az login
    $account = az account show --output json | ConvertFrom-Json
}

$tenantId = $account.tenantId
$subscriptionId = $account.id

# SP
$spName = "github-actions-$subscriptionId"
$spUri  = "http://$spName"

try {
    $sp = az ad sp show --id $spUri --output json 2>$null | ConvertFrom-Json
} catch {
    $sp = $null
}

if (-not $sp) {
    Write-Host "Creating Service Principal..."
    $sp = az ad sp create-for-rbac --name $spName --role Contributor --scopes "/subscriptions/$subscriptionId" --output json 2>$null | ConvertFrom-Json
    $clientId = $sp.appId
    $clientSecret = $sp.password
} else {
    Write-Host "Resetting Client Secret For Existing SP..."
    $cred = az ad sp credential reset --id $sp.appId --credential-description "github-actions" --years 1 --output json 2>$null | ConvertFrom-Json
    $clientId = $sp.appId
    $clientSecret = $cred.password
}

if (-not $clientSecret) { throw "Client Secret Was Not Generated." }

# Prompt for Storage Account and Container
$storageAccount = Read-Host "Enter Azure Storage Account Name"
$resourceGroup   = Read-Host "Enter Resource Group Name"
$containerName   = Read-Host "Enter Container Name"

# Create SAS Token (Read, Write, List)
$sasToken = az storage container generate-sas `
    --account-name $storageAccount `
    --name $containerName `
    --permissions rwl `
    --expiry (Get-Date).AddYears(1).ToString("yyyy-MM-dd") `
    --https-only `
    --output tsv

if (-not $sasToken) { throw "Failed to generate SAS Token." }

# Display SP and SAS Info
Write-Host "`nAzure Service Principal Info`n"
Write-Host "AZURE_TENANT_ID       : $tenantId"
Write-Host "AZURE_SUBSCRIPTION_ID : $subscriptionId"
Write-Host "AZURE_CLIENT_ID       : $clientId"
Write-Host "AZURE_CLIENT_SECRET   : $clientSecret"
Write-Host "`nAzure Storage SAS Token`n$sasToken"
Write-Host "`nCopy & Input Secrets To Github Repo`n"
