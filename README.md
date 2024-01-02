<h1 align="center">
  Dotfiles 
  <img src="https://blog.zachinachshon.com/assets/images/localdev/dotfiles/dotfiles-blog-220x230.png" alt="File" width="50" height="50"
</h1>

## Restore your Dotfiles manually

* Install git
* Clone your dotfiles repository `git clone [your repository of dotfiles] $HOME/.dotfiles`
* Go to your dotfiles folder `cd $HOME/.dotfiles`
* Give execution permissions to the install script `chmod +x install`
* Execute the install script `./install`
* Restart your terminal

## Estructure of the dotfiles repository

```bash
├── 📁 doc                 # Documentation of your dotfiles
├── 📁 editors             # Settings of your editors (vim)
├── 📁 git                 # git config
├── 📁 langs               # Config for programming languages/libraries
├── 📁 os                  # Specific config of your Operative System 
├── 📁 scripts             # Your custom scripts
├── 📁 shell               # Bash/Zsh/Fish… configuration files
└── 📁 symlinks            # The config of your symlinks
```

## Tools
The following tools are included in this repository:

- **exa:** ls replacement
- **fzf:** fuzzy finder
- **bat:** cat replacement, only for macOS
- **programs**
- **aliases**
- **bash config**
- **zsh config**
- **A terminal theme**
- **git config**
- **nvim config**
- **powershell config**: by  *[devaslife](https://github.com/craftzdog)*
- **scripts**

## Windows

For windows, you need to reed the documentation in the folder `doc/Windows.md`

## Preview of the dotfiles

### Nvim

### Zsh

<p align="center">
  <b>Bash config</b><br>
  <img src="https://i.ibb.co/pXMLKZT/Screenshot-2023-02-12-at-15-14-29.png">
</p>

<p align="center">
  <b>Init.vim Transparent</b><br>
  <img src="https://i.ibb.co/df3YpSB/ejem1.png">
</p>

<p align="center">
  <b>PowerShell</b><br>
  <img src="https://i.ibb.co/Jzr0387/img1.png">
</p>

## TODO
- [ ] Update images of the preview
- [ ] In windows, update the shortcuts for windows manager on PowerToys
- [ ] In windows invert the keys of the keyboard and the mouse
- [ ] Search for translate in spootlight and PowerToys
- [ ] Update dotfiles and documentation for linux
- [ ] Make windows terminal faster

## References
This repository is based on [dotly](https://github.com/CodelyTV/dotly/)
