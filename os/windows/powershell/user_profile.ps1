# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Import-Module PSReadLine
Import-Module posh-git
$omp_config = Join-Path $PSScriptRoot ".\takuya.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression
Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

#Functions
function gp {
    param(
        [string]$mensaje,
        [string]$rama
    )

    & git add -A
    & git commit -m $mensaje
    & git push origin $rama
}

function gac {
    param(
        [string]$mensaje
    )

    & git add -A
    & git commit -m $mensaje
}

# Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias c clear
Set-Alias cat type
Set-Alias mv move-item
Set-Alias rm remove-item -Force
Set-Alias touch new-item
Set-Alias pwd Get-Location


# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
