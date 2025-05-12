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
winget install Discord.Discord
winget install ONLYOFFICE.DesktopEditors
winget install 9P3JFR0CLLL6 # mpv Video Player
winget install KDE.Okular
winget install Valve.Steam
winget install CrystalDewWorld.CrystalDiskInfo
winget install CrystalDewWorld.CrystalDiskMark
winget upgrade --all
