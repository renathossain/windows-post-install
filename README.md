# windows-post-install

A Windows 11 post-installation script to automate the setup process.

- Within the cloned `windows-post-install` folder in File Explorer, `Right Click` and select `Open in Terminal` and run the following commands in it:
- Enable running scripts: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Install & Configure all Programs: `.\postinstall.ps1`
- Search for new packages using `winget search "Package Name"`

## Undervolting

The script disables VBS/Memory Integrity (required or ThrottleStop cannot write CPU voltage), installs ThrottleStop to `C:\ThrottleStop`, and registers a scheduled task (`ThrottleStop`) that reapplies the undervolt at every logon.

On first setup, ThrottleStop launches for a one-time GUI configuration:

1. Click **FIVR**.
2. Tick **Unlock Adjustable Voltage**.
3. Set **CPU Core**, **CPU Cache**, and **Intel GPU** each to **-100** (Offset, Adaptive).
4. Click **OK - Save voltages immediately**, then **Save** in the main window.

ThrottleStop must stay running in the tray (closing it reverts the offsets). To make the config fully automated (no GUI step on future installs), copy the generated `C:\ThrottleStop\ThrottleStop.ini` into this repo next to `postinstall.ps1` — the script deploys it automatically.
