New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.config\powershell" -Target "$env:USERPROFILE/.dotfiles/os/windows/powershell"
mkdir "$env:USERPROFILE\Documents\PowerShell"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "$env:USERPROFILE/.dotfiles/os/windows/config/Microsoft.PowerShell_profile.ps1"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\AppData\Local\nvim" -Target "$env:USERPROFILE/.dotfiles/editors/nvim"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gitconfig" -Target "$env:USERPROFILE/.dotfiles/git/.gitconfig"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gitignore_global" -Target "$env:USERPROFILE/.dotfiles/git/.gitignore_global"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gitmessage.txt" -Target "$env:USERPROFILE/.dotfiles/git/.gitmessage.txt"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal\LocalState\settings.json" -Target "$env:USERPROFILE/.dotfiles/os/windows/Terminal/settings.json"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\AppData\Roaming\Code\User\keybindings.json" -Target "$env:USERPROFILE/.dotfiles/editors/vscode/keybindings.json"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\AppData\Roaming\Code\User\settings.json" -Target "$env:USERPROFILE/.dotfiles/editors/vscode/settings.json"
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\AppData\Roaming\Code\User\snippets" -Target "$env:USERPROFILE/.dotfiles/editors/vscode/snippets"