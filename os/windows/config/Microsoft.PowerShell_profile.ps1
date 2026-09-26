Invoke-Expression (&starship init powershell)
Import-Module -Name Terminal-Icons
Set-PSReadLineOption -PredictionSource History
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

function update {
   winget upgrade -h --all
}

Set-Alias vim nvim
Set-Alias grep findstr
Set-Alias touch new-item

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Import-Module -Name Microsoft.WinGet.CommandNotFound
