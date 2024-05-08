
# Install Winget
Write-Host "Installing Winget"
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://git.io/winget-installer')

Write-Host

# Install Nerd Fonts Hack
Write-Host "Please Install Nerd Fonts Hack"

# Install PSReadLine 2.1.0w 
Write-Host "Installing PSReadLine 2.1.0"
Install-Module PSReadLine -RequiredVersion 2.1.0

Write-Host

# Install PSReadLine 2.1.0w 
Write-Host "Installing GitHub CLI"
winget install --id GitHub.cli

Write-Host

# Install Scoop
Write-Host "Installing Scoop"
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Set-ExecutionPolicy Unrestricted
iwr -useb get.scoop.sh | iex
     scoop install curl

Write-Host

# Install Scoop apps
Write-Host "Installing Scoop apps"
$appsScoop = @("neovim", "gcc", "nvm")
foreach ($app in $appsScoop) {
    scoop install $app
    Write-Host "$app has been installed successfully."
}

$version = Read-Host "Enter the version of Node.js to install"
nvm install $version
nvm use $version

Write-Host

Write-Host "Installing Autocomplete"
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Write-Host "Install terminal icons"
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Import-Module Terminal-Icons

Write-Host

# Install Fzf
Write-Host "Installing Fzf"
Install-Module -Name PSFzf -Scope CurrentUser -Force
Set-PsFzfoPTION -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

Write-Host

# Define the list of apps to install
$apps = @("git", "vscode", 
            "java", "python3",
            "microsoft.powertoys",
            "fzf", "exa",
            "intellij-idea-community", 
            "google-chrome", "dbeaver")

# Iterate over the list of apps and install each one
foreach ($app in $apps) {
    winget install -e $app
    Write-Host "$app has been installed successfully."
}

Write-Host


Write-Host "Installing nvim-plug"
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
Write-Host "Copying and moving the nvim folder to appdata nvim"

Write-Host "Executing symlink.ps1"
.\symlink.ps1

Write-Host "Installing private fonts"
mkdir ~/.fonts
cd ~/.fonts && git clone git@github.com:erickvasm/font.git
