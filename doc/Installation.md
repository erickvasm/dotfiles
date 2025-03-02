# Installation

## MacOs computer setup

- Log in iCloud and Sync all Keychain passwords
- Update Mac
- Restore `~/.ssh` from iCloud
- Execute the dotfiles installer
- Login in Mail and sync all accounts
- Go to `Preferences/Desktop and Dock` and set the dock hiding to `Automatically`
- Go to `Preferences/General` and enable font smoothing (if retina display)
- Open safari and go to `Tabs` and set the tab layout to `Compact`
- Download addGuard [Link](https://adguard-dns.io/en/public-dns.html)
- Open Rectangle and import the configuration from `~/.dotfiles/mac/Rectangle`
  - Go to `Settings/General/Login items/` and add Rectangle
- Open JetBrains Toolbox
  - Login
  - Enable "generate shell scripts in ~/bin"
  - Install IntelliJ
- Open IntelliJ
  - Import from JetBrains account
  - Sync plugins
- Open VsCode
  - Sync settings
  - Install settings sync extension
- Open iTerm2
  - Select load preferences from URL and use ~/.dotfiles/mac/iTerm. On the next prompt select "No" to not save the changes
  - Change the font and the theme
- Restart

With the script `macos.sh` have the default configuration for a new mac, but you can use the script to export your own configuration.

```bash
./mac-setup.sh export /Users/graifin/.dotfiles/os/mac/settings
```

## Remap Caps-Lock

- Remapping your Caps Lock key to keyboard.
  ![Remap Caps Lock](https://i.ibb.co/zXf6R65/Screenshot-2024-01-01-at-2-01-45-PM.png)

- Remapping `Paste and Match Style` to `Cmd + Shift + V`
  ![Remap Paste and Match Style](https://i.ibb.co/XbNSHCt/Screenshot-2024-01-06-at-8-53-52-PM.png)

## Linux computer setup

The same as MacOs but without the iCloud part

- For setup ubuntu, you can read this article
  [Ubuntu](https://medium.com/@erickvasm/ubuntu-setup-29323c81a258)
- For manage the password I use Bitwarden

## Windows computer setup

- Uninstall OneDrive
- I use the icloud plugin to synchronize passwords.
- Clean the bar and leave it with only the windows icon and the search icon and remove unnecessary apps
  - I leave only the browser, explorer, store and terminal icon
- Update Microsoft Edge
  - login in Microsoft Edge
  - Sync all accounts
- Invert the scroll direction and the keymap (like mac)
  - [References](https://superuser.com/questions/543971/how-to-change-the-windows-alttab-hotkey-to-something-else/1588228#1588228)
- Install [Jetbrains](https://www.jetbrains.com/toolbox-app/)

---

1. First you must install the app installer in the store [winget](https://apps.microsoft.com/detail/9nblggh4nns1?rtc=1&hl=es-cr&gl=CR).
2. Then install winget
3. Next would be to install git cli

- `winget install --id GitHub.cli`

4. Then clone the repository and rename it .dotfiles
5. The next thing will be to download powershell and windows terminal

Run as a admin:

```bash
cd .dotfiles/os/windows
./windows.ps1
```

Note: If the script is not marked as executable, you may receive an error message when trying to run it. To fix this, you can use the following command to make the script executable:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

or

PS C:\path\to\script> Set-ExecutionPolicy Unrestricted
```

- Run symlink.ps1 as manager
- Import Terminal config

## Setup lid of laptop

- Go to `Preferences/Power` and set the lid to `Do nothing` when is closed
  ![Setup lid](https://i.ibb.co/YjnzHvX/Screenshot-2024-01-02-221952.png "Setup")

## Important Directories to know

```powershell
Users >  NameUser >  .config >  powershell

Users >  NameUser > Documents >  PowerShell

User > NameUser > AppData > Local > nvim
```
