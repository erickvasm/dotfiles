<h1 align="center">
  Dotfiles 
  <img src="https://blog.zachinachshon.com/assets/images/localdev/dotfiles/dotfiles-blog-220x230.png" alt="File" width="50" height="50"
</h1>

## Restore your Dotfiles manually

- Install git
- Clone your dotfiles repository `git clone [your repository of dotfiles] $HOME/.dotfiles`
- Go to your dotfiles folder `cd $HOME/.dotfiles`
- Give execution permissions to the install script `chmod +x install`
- Execute the install script `./install`
- Restart your terminal

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
- **powershell config**: by _[devaslife](https://github.com/craftzdog)_
- **scripts**

`NOTE: VSCode configurations are included so that they are versioned and if someone wants to have the same configuration. Although this is not necessary `

## Windows

For windows, you need to read the documentation in the folder `doc/Windows.md`

## Preview of dotfiles

<table>
  <tr>
    <td align="center">
      <b>Bash config</b><br>
      <img src="https://i.ibb.co/YNZX005/Screenshot-2024-04-22-at-11-05-43-AM.png">
    </td>
    <td align="center">
      <b>Bash with starhip</b><br>
      <img src="https://i.ibb.co/RbbFQS4/Screenshot-2024-01-11-at-12-40-44-PM.png">
    </td>
  </tr>
  <tr>
    <td align="center">
      <b>Init.vim</b><br>
      <img src="https://i.ibb.co/8DZ8RFB/Screenshot-2024-04-22-at-11-08-08-AM.png">
    </td>
    <td align="center">
      <b>LazzyVim config</b><br>
      <img src="https://i.ibb.co/XCsrZFN/Screenshot-2024-01-11-at-12-42-49-PM.png">
    </td>
  </tr>
  <tr>
    <td align="center">
      <b>PowerShell with Tacuya configs</b><br>
      <img src="https://i.ibb.co/Jzr0387/img1.png">
    </td>
    <td align="center">
      <b>PowerShell with Starchip</b><br>
      <img src="https://i.ibb.co/YDmRCMg/terminal.png">
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <b>VScode configs</b><br>
      <img src="https://i.ibb.co/Lx7QZTg/Screenshot-2024-01-11-at-12-48-18-PM.png">
    </td>
  </tr>
</table>

## References

This repository is based on [dotly](https://github.com/CodelyTV/dotly/)
