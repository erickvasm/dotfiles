$email = Read-Host "Ingresa tu correo electrónico para GitHub"
$sshPath = "$env:USERPROFILE\.ssh"
$nameFile = Read-Host "Ingresa el nombre del archivo"
$keyPath = "$sshPath\$nameFile"

# Create the ssh folder if it doesn't exist
if (!(Test-Path -Path $sshPath)) {
    New-Item -ItemType Directory -Path $sshPath
}

# move to the ssh folder
Set-Location $sshPath

Write-Host

# Generate a new ssh key
ssh-keygen -t rsa -b 4096 -C $email

Write-Host

# start the ssh-agent
eval "$(ssh-agent -s)"

Write-Host

# Add the ssh key to ssh-agent
ssh-add $keyPath

# Cat the ssh key and copy it to the clipboard
$key = cat $keyPath.pub
$key | clip
Write-Host "SSH key copied to clipboard"
