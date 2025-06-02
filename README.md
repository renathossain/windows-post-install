# windows-post-install

A Windows 11 post-installation script to automate the setup process.

- Open Powershell as Administrator and run the following:
- Enable running scripts: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Install & Configure all Programs: `.\postinstall.ps1`
- Search for packages using `winget search "Package Name"`
