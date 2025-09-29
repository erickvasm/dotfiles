<h1 align="center">
  Dotfiles

  <picture style="width: 30px; height: 30px;">
    <source media="(prefers-color-scheme: light)" srcset="https://i.ibb.co/GQSTr7r2/Git-Hub-Mark-ea2971cee799.png">
    <source media="(prefers-color-scheme: dark)" srcset="https://i.ibb.co/nMXjC9zk/648256.png">
    <img alt="GitHub logo" src="https://i.ibb.co/nMXjC9zk/648256.png" style="width: 5%; height: 5%;">
  </picture>
</h1>

<img alt="img" src="https://i.ibb.co/whdSrMHL/Screenshot-2025-09-28-at-8-54-28-AM.png">

## Restore your Dotfiles manually 

1. Install git
2. Clone your dotfiles repository:
   ```bash
   git clone https://github.com/erickvasm/dotfiles.git $HOME/.dotfiles
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
6. Execute:

   ```bash
   tail -f install.log
   ```

7. Restart de computer


## Project Structure

```bash
├── docs                    # Documentation of installation and tools
├── export_logs             # Logs of exported configurations
├── install                 # Bootstrap and helper scripts
├── os                      # OS-specific configs
│   ├── unix
│   │   ├── linux
│   │   ├── mac
│   │   └── packages/       # Bash, ZSH, Git, Vim, VSCode, etc.
│   └── windows/
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

## Utilities

### `export_config.sh`

This script exports a list of globally installed packages and configurations from various package managers.

**Usage:**

```bash
./utilities/export_config.sh
```

This will create the following files in the `export_logs` directory:

*   `volta_globals.txt`: A list of global tools installed with Volta.
*   `pip_global_packages.txt`: A list of global packages installed with pip.
*   `gradle_properties.txt`: Gradle properties.
*   `Brewfile`: A list of packages installed with Homebrew.

These files can be used to manually update the package lists in `os/unix/python_node.conf` and `os/unix/mac/Brewfile`.

### `plist-config.sh`

This script manages macOS system preferences by exporting and importing configurations using `.plist` files.

**Usage:**

*   **Export:**

    ```bash
    ./utilities/plist-config.sh export
    ```

    This will export your current system preferences to `.plist` files located in `os/unix/mac/settings`.

*   **Import:**

    ```bash
    ./utilities/plist-config.sh import
    ```

    This will import the preferences from the `.plist` files in `os/unix/mac/settings`, applying them to your system.

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
