<h1 align="center">
  Dotfiles
  <img src="https://blog.zachinachshon.com/assets/images/localdev/dotfiles/dotfiles-blog-220x230.png" alt="File" width="50" height="50">
</h1>

## Restore your Dotfiles manually

1. Install git
2. Clone your dotfiles repository:
   ```bash
   git clone [your repository of dotfiles] $HOME/.dotfiles
  ```

3. Go to your dotfiles folder:

   ```bash
   cd $HOME/.dotfiles
   ```
4. Give execution permissions to the install script:

   ```bash
   chmod +x install/bootstrap.sh
   ```
5. Execute the install script:

   ```bash
   ./install/bootstrap.sh
   ```
6. Restart your terminal


## Project Structure

```bash
├── docs                    # Documentation of installation and tools
├── install                 # Bootstrap and helper scripts
├── os                      # OS-specific configs
│   ├── unix
│   │   ├── linux
│   │   ├── mac
│   │   └── packages/       # Bash, ZSH, Git, Vim, VSCode, etc.
│   └── windows/
├── utilities               # Utility scripts
└── README.md
```

---

## Tools and Features

This repository includes:

* **exa:** Enhanced `ls`
* **fzf:** Fuzzy finder
* **bat:** Better `cat` (macOS only)
* **Shell configs:** Bash & Zsh setups
* **Terminal themes**
* **Git global config**
* **NeoVim & LazyVim config**
* **VSCode user settings**
* **PowerShell config** (credits to [devaslife](https://github.com/craftzdog))
* **Utility scripts:** for video compression, sleep prevention, and plist automation

> 💡 *Note: VSCode settings are included mainly for backup/versioning.*

---

## Windows

For Windows setup instructions, refer to:

```
docs/installation-window.md
```

---

## Preview

### Bash config

![bash config](https://i.ibb.co/YNZX005/Screenshot-2024-04-22-at-11-05-43-AM.png)

### Bash with Starship

![bash with starship](https://i.ibb.co/RbbFQS4/Screenshot-2024-01-11-at-12-40-44-PM.png)

### Init.vim

![init vim](https://i.ibb.co/8DZ8RFB/Screenshot-2024-04-22-at-11-08-08-AM.png)

### LazyVim config

![lazyvim](https://i.ibb.co/XCsrZFN/Screenshot-2024-01-11-at-12-42-49-PM.png)

### PowerShell with Takuya config

![powershell takuya](https://i.ibb.co/Jzr0387/img1.png)

### PowerShell with Starship

![powershell starship](https://i.ibb.co/YDmRCMg/terminal.png)

### VSCode config

![vscode](https://i.ibb.co/94rX2Mp/Screenshot-2024-04-22-at-11-46-39-AM.png)

