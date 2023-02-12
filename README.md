# My personal Dotfiles

## Introduction
Dotfiles are configuration files for various tools and applications that are used on a Unix-based system and windows. 

This repository contains my personal dotfiles and is intended to be used as a starting point for others who want to use similar configurations.

## Tools
The following tools are included in this repository:

- **exa:** ls replacement
- **fzf:** fuzzy finder
- **bat:** cat replacement, only for macOS
- **programs**
- **aliases**
- **bash config**
- **git config**
- **nvim config**
- **powershell config**: by  *[devaslife](https://github.com/craftzdog)*
- **keyssh script**
- **zsh config**
- **A terminal theme**

## Images

<p align="center">
  <b>PowerShell</b><br>
  <img src="https://i.ibb.co/Jzr0387/img1.png">
</p>

<br>
<br>

<p align="center">
  <b>Nvim Transparent</b><br>
  <img src="https://i.ibb.co/df3YpSB/ejem1.png">
</p>

<br>
<br>

<p align="center">
  <b>Bash config</b><br>
  <img src="https://i.ibb.co/pXMLKZT/Screenshot-2023-02-12-at-15-14-29.png">
</p>

## Installation
1. Clone this repository to your home directory:
https://github.com/erickvasm/dotfiles.git

2. Run the install script for linux:
```bash
cd dotfiles
cd linux
chmod +x linux.sh
./linux.sh
```

3. Run the install script for macOS:
```powershell
cd dotfiles
cd mac
chmod +x macos.sh
./macos.sh
```

4. Run the install script for windows:
```bash
cd dotfiles
cd windows
./windows.ps1
```

Note: If the script is not marked as executable, you may receive an error message when trying to run it. To fix this, you can use the following command to make the script executable:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

or

PS C:\path\to\script> Set-ExecutionPolicy Unrestricted
```

5. Run the install script for keyssh:
```bash
cd dotfiles
cd key
./keyssh.sh
```

6. Run the install script for keyssh windows:
```powershell
cd dotfiles
cd windows
./keyssh.ps1
```

## Usage
After installation, the configuration files will be automatically loaded the next time you start a new terminal session or run a shell.

## Customization
You can customize these dotfiles to your liking by editing the files you want. The changes will be reflected in your configuration the next time you start a new terminal session or run a shell.

## License
This project is licensed under the GNU GENERAL PUBLIC - see the [LICENSE](LICENSE) file for details.
