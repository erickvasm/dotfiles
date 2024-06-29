Invoke-Expression (&starship init powershell)
Import-Module -Name Terminal-Icons
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
function update {
   winget upgrade -h --all
}
Set-Alias vim nvim
Set-Alias grep findstr
Set-Alias cat type
Set-Alias mv move-item
Set-Alias rm remove-item -Force
Set-Alias touch new-item
Set-Alias pwd Get-Location
