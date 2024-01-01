# Pasos PowerShell
 
1. Descargar fuente: NerdFont Hack
2. Instalar siguiientes paquetes: 

```sh
  Install-Module posh-git -Scope CurrentUser
  Install-Module oh-my-posh -Scope CurrentUser
```
            
3. notepad $PROFILE, dentro del archivo: 

```sh
 . $env:USERPROFILE\.config\powershell\user_profile.ps1
```

4. Abrimos terminal en modo administrador: 

```sh             
   Set-ExecutionPolicy Unrestricted
```

5. Instalamos scoop 

```sh
     iwr -useb get.scoop.sh | iex
     scoop install curl
```

6. Instalar Git

```sh
    winget install Git.Git
```

7. scoop install neovim gcc

8. Clonar este repositorio en .config

9. Instalar nodejs 

```sh
    scoop install nvm
    nvm install [version]
    nvm use [version]
```

10. Intalar terminal de icons

```sh
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force
    Import-Module Terminal-Icons
```   
11. Install-Module -Name Z -Force

12. Instalar autocompletado

```sh
    Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
``` 

13. Instalar FZf

```sh
    Install-Module -Name PSFzf -Scope CurrentUser -Force
     Set-PsFzfoPTION -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
```
 

## Pasos init.vim
 
1. Instalar vim-plug

3. Intalar Plug: :PlugInstall

4. Instalar Coc
       * coc auto close
       * coc html css js
       * coc emmet

5. npm install -g live-server
 
