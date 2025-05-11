# Install Apps using winget
winget install eloston.ungoogled-chromium
winget install Discord.Discord
winget install ONLYOFFICE.DesktopEditors
winget install 9P3JFR0CLLL6 # mpv Video Player
winget install KDE.Okular
winget install Valve.Steam
winget install CrystalDewWorld.CrystalDiskInfo
winget install CrystalDewWorld.CrystalDiskMark
winget install glzr-io.glazewm

scoop install git
scoop bucket add extras
scoop install extras/firefox

winget upgrade --all
scoop update *
scoop cleanup *
