# Github Rep
$RepoUrl = Read-Host "Enter GitHub repo URL (https://github.com/user/repo)"
$Repo = ($RepoUrl -replace "^https://github.com/", "").TrimEnd("/").TrimEnd(".git")
Write-Host "Repo Detected: $Repo"

# Azure Login
try {
    $account = az account show --output json 2>$null | ConvertFrom-Json
    if (-not $account) { throw "Not Logged In" }
    Write-Host "Azure Login Detected: $($account.user.name)"
} catch {
    Write-Host "Logging in to Azure..."
    az login
    $account = az account show --output json | ConvertFrom-Json
}

$tenantId = $account.tenantId
$subscriptionId = $account.id

# GitHub Login
while ($true) {
    gh auth status 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) { break }
    Write-Host "Please Log Into GitHub"
    gh auth login
}

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
    Write-Host "Resetting client secret for existing SP..."
    $cred = az ad sp credential reset --id $sp.appId --credential-description "github-actions" --years 1 --output json 2>$null | ConvertFrom-Json
    $clientId = $sp.appId
    $clientSecret = $cred.password
}

if (-not $clientSecret) { throw "Client Secret Was Not Generated." }

# 5. Push secrets to GitHub
$secrets = @{
    AZURE_TENANT_ID       = $tenantId
    AZURE_SUBSCRIPTION_ID = $subscriptionId
    AZURE_CLIENT_ID       = $clientId
    AZURE_CLIENT_SECRET   = $clientSecret
}

foreach ($key in $secrets.Keys) {
    Write-Host "Uploading Secret $key..."
    
    $tempFile = [System.IO.Path]::GetTempFileName()
    $secrets[$key] | Set-Content -Path $tempFile -NoNewline
    
    gh secret set $key --repo $Repo --body "$(Get-Content -Raw $tempFile)"
    
    Remove-Item $tempFile
}
