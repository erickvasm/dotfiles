# Install PSReadLine 2.1.0w 
Write-Host "Installing PSReadLine 2.1.0"
Install-Module PSReadLine -RequiredVersion 2.1.0

Write-Host

# Install PSReadLine 2.1.0w 
Write-Host "Installing GitHub CLI"
winget install --id GitHub.cli

gh auth login

Write-Host "Installing Choco"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Write-Host

Write-Host "Installing starship"
choco install starship

# Install Scoop
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

Write-Host

# Install Scoop
Write-Host "Installing Scoop"
iex "& {irm get.scoop.sh} -RunAsAdmin"

# Install Scoop apps
Write-Host "Installing Scoop apps"
$appsScoop = @("neovim", "gcc", "volta", "fzf")
foreach ($app in $appsScoop) {
    scoop install $app
    Write-Host "$app has been installed successfully."
}

volta install node

Write-Host

# Define the list of apps to install
$apps = @("git", "vscode", 
            "java", "python3",
            "microsoft.powertoys",
            "google-chrome", "dbeaver")

# Iterate over the list of apps and install each one
foreach ($app in $apps) {
    winget install -e $app
    Write-Host "$app has been installed successfully."
}

winget install eza-community.eza

Write-Host

Write-Host "Installing nvim-plug"
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
Write-Host "Copying and moving the nvim folder to appdata nvim"

Write-Host "Installing Autocomplete"
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Set-PSReadLineOption -PredictionSource History

Write-Host "Install terminal icons"
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Import-Module Terminal-Icons

Write-Host

# Install Fzf
Write-Host "Installing Fzf"
Install-Module -Name PSFzf -Scope CurrentUser -Force
Set-PsFzfoPTION -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'//todo error

Write-Host

Write-Host "Installing private fonts"
mkdir ~/.fonts
cd ~/.fonts && gh repo clone erickvasm/DankMono
