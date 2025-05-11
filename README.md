# windows-post-install

A Windows 11 post-installation script and dotfiles to automate the setup process for Windows 11 and the GlazeWM window manager.

- We use the Scoop Package Manager: https://scoop.sh/
- Open Powershell as Administrator and run the following:
- Enable running scripts: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Install Scoop Package Manager: `& ".\install.ps1"`
- Install & Configure all Programs: `& ".\postinstall.ps1"`
