# Self-elevate script if not running as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  try {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -ErrorAction Stop
    exit 0
  } catch {
    Write-Host "Privilege elevation was cancelled by the user. Exiting..."
    exit 1
  }
}

# Undervolt CPU (locked H-series, Intel XTU unsupported: use ThrottleStop)
# Disable VBS/Memory Integrity (blocks ThrottleStop from writing CPU voltage registers)
$hvis = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
New-Item -Path $hvis -Force | Out-Null
Set-ItemProperty -Path $hvis -Name "Enabled" -Value 0 -Type DWord

# Install ThrottleStop (portable) into a permanent folder
winget install -e --id TechPowerUp.ThrottleStop --location C:\ThrottleStop
$tsExe = "C:\ThrottleStop\ThrottleStop.exe"
if (-not (Test-Path $tsExe)) {
  $tsExe = (Get-ChildItem "$env:LOCALAPPDATA\Microsoft\WinGet\Packages" -Recurse -Filter ThrottleStop.exe |
    Select-Object -First 1).FullName
}

# Deploy committed FIVR config if present, otherwise configure once in the GUI (FIVR: CPU Core/Cache/Intel GPU -100 mV)
if (Test-Path "$PSScriptRoot\ThrottleStop.ini") {
  Copy-Item "$PSScriptRoot\ThrottleStop.ini" (Split-Path $tsExe) -Force
}

# Apply undervolt at every logon (elevated, no UAC prompt)
schtasks /Create /TN "ThrottleStop" /TR "`"$tsExe`"" /SC ONLOGON /DELAY 0000:30 /RL HIGHEST /F

# Launch now for the one-time FIVR configuration (offset: CPU Core -100, CPU Cache -100, Intel GPU -100)
Start-Process $tsExe
