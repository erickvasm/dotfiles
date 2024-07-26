. $env:USERPROFILE\.config\powershell\user_profile.ps1

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Import-Module -Name Microsoft.WinGet.CommandNotFound
