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

# Set Windows to use UTC to avoid time conflict with Linux
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation"
$propertyName = "RealTimeIsUniversal"
$propertyValue = 1
if (Test-Path $registryPath) {
  Set-ItemProperty -Path $registryPath -Name $propertyName -Value $propertyValue -Type DWord
}

# Install Apps using winget
winget install Git.Git
winget install 7zip.7zip
winget install Mozilla.Firefox
winget install eloston.ungoogled-chromium
winget install Microsoft.VisualStudioCode
winget install Discord.Discord
winget install ONLYOFFICE.DesktopEditors
winget install VideoLAN.VLC
winget install 9P3JFR0CLLL6 # mpv Video Player
winget install KDE.Okular
winget install Valve.Steam
winget install EpicGames.EpicGamesLauncher
winget install CrystalDewWorld.CrystalDiskInfo
winget install CrystalDewWorld.CrystalDiskMark
winget install LocalSend.LocalSend
winget upgrade --all

# Install VSCode extensions
& "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd" --install-extension yzhang.markdown-all-in-one
& "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd" --install-extension renathossain.markdown-runner
& "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd" --install-extension dbaeumer.vscode-eslint
& "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd" --install-extension esbenp.prettier-vscode

# Press any key to exit code
Write-Host "`nInstallation finished. Press any key to exit..."
[void][System.Console]::ReadKey($true)
