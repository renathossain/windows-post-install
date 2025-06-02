# windows-post-install

A Windows 11 post-installation script to automate the setup process.

- Within the cloned `windows-post-install` folder in File Explorer, `Right Click` and select `Open in Terminal` and run the following commands in it:
- Enable running scripts: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Install & Configure all Programs: `.\postinstall.ps1`
- Search for new packages using `winget search "Package Name"`
