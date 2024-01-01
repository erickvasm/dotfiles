
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
            "fzf", "exa", "bat", 
            "intellij-idea-community", 
            "google-chrome", "dbeaver")

# Iterate over the list of apps and install each one
foreach ($app in $apps) {
    winget install -e $app
    Write-Host "$app has been installed successfully."
}

Write-Host


Write-Host "Installing nvim-plug"
Invoke-WebRequest -Uri https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -OutFile $env:LOCALAPPDATA\nvim-data\site\autoload\plug.vim
Write-Host "Copying and moving the nvim folder to appdata nvim"
Copy-Item -Path $env:USERPROFILE\Documents\Projects\dotfiles\nvim -Destination $env:LOCALAPPDATA\nvim -Recurse -Force


Write-Host

# ask if the user wants to install wsl2
$wsl = Read-Host "Do you want to install wsl2? (y/n)"
if ($wsl -eq "y") {
    Write-Host "Installing wsl2"
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
    Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing
    Add-AppxPackage .\Ubuntu.appx
    Write-Host "Installing wsl2"
    wsl --set-default-version 2
    Write-Host "Installing Ubuntu 22.04"
    wsl --install -d Ubuntu-22.04
}
