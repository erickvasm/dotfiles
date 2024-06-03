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
- Open Slack
  - Login
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

- Run the install script for windows in administrator mode:

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

- I use the icloud plugin to synchronize passwords.
- Clean the bar and leave it with only the windows icon and the search icon
  - I leave only the browser, explorer, store and terminal icon
- Update Microsoft Edge
  - login in Microsoft Edge
  - Sync all accounts
- Invert the scroll direction and the keymap (like mac)
  - [References](https://superuser.com/questions/543971/how-to-change-the-windows-alttab-hotkey-to-something-else/1588228#1588228)

## Setup lid of laptop

- Go to `Preferences/Power` and set the lid to `Do nothing` when is closed
  ![Setup lid](https://i.ibb.co/YjnzHvX/Screenshot-2024-01-02-221952.png "Setup")

## Important Directories to know

```powershell
Users >  NameUser >  .config >  powershell

Users >  NameUser > Documents >  PowerShell

User > NameUser > AppData > Local > nvim
```
