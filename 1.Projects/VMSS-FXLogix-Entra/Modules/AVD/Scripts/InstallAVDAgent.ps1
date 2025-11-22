param (
    [Parameter(Mandatory = $true)]
    [string]$RegistrationToken
)

$ErrorActionPreference = "Stop"

$LogPath = "C:\AVD\InstallAVDAgent.log"
New-Item -Path (Split-Path $LogPath) -ItemType Directory -Force | Out-Null
"=== InstallAVDAgent.ps1 started at $(Get-Date) ===" | Out-File $LogPath -Append

function Log {
    param([string]$Message)
    "$((Get-Date).ToString('u')) : $Message" | Out-File $LogPath -Append
}


$MaxWaitMinutes = 10
$WaitedMinutes = 0

Log "Waiting for Entra AD join to complete..."
while ($true) {
    try {
        $joined = (Get-ComputerInfo | Select-String "AzureADJoined\s+:\s+True")
        if ($joined) { break }
    } catch { }

    Start-Sleep -Seconds 15
    $WaitedMinutes += 0.25
    if ($WaitedMinutes -ge $MaxWaitMinutes) {
        Log "Timed out waiting for Entra AD join."
        exit 1
    }
}

Log "Entra AD join complete."


$RebootRequiredPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"
if (Test-Path $RebootRequiredPath) {
    Log "Reboot required after Entra AD join. Rebooting..."
    Restart-Computer -Force
    Start-Sleep -Seconds 60
    exit 0
}


$downloads = @(
    @{ Name = "AVDAgent.msi";     Url = "https://go.microsoft.com/fwlink/?linkid=2310011"; TokenRequired = $true  },
    @{ Name = "AVDBootloader.msi"; Url = "https://go.microsoft.com/fwlink/?linkid=2311028"; TokenRequired = $false }
)

$dest = "C:\AVD"
New-Item -Path $dest -ItemType Directory -Force | Out-Null

foreach ($item in $downloads) {
    $file = Join-Path $dest $item.Name
    Log "Downloading $($item.Name) from $($item.Url)..."
    Invoke-WebRequest -Uri $item.Url -OutFile $file

    $arguments = "/i `"$file`" /qn"
    if ($item.TokenRequired) { $arguments += " REGISTRATIONTOKEN=$RegistrationToken" }

    Log "Installing $($item.Name) with arguments: $arguments"
    $proc = Start-Process "msiexec.exe" -ArgumentList $arguments -Wait -PassThru
    Log "$($item.Name) install exited with code $($proc.ExitCode)"
}

Log "AVD Agent + Bootloader installation completed."
