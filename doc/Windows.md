# Entorno de desarrollo PowerShell
 
 
# Directorios

# 1

Users >  NameUser >  .config >  powershell > tacuya.omp, tacuya.omp.json.bak & user_profile.ps1

# 2

Users >  NameUser > Documents >  PowerShell > Microsoft.PowerShell_profile.ps1

# 3

User > NameUser > AppData > Local > nvim > init.vim      

 
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
    Install-Module -Name Terminal-Icons -Repository PSGalley -Force
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
 

# Pasos Nvim
 
1. Instalar vim-plug

2. En el directorio nvim, clonar mi repositorio de nvim

3. Intalar Plug: :PlugInstall

4. Instalar Coc
       * coc auto close
       * coc html css js
       * coc emmet

5. npm install -g live-server
 
# Referencias

1. https://github.com/ryanoasis/nerd-fonts

2. https://github.com/craftzdog/dotfiles-public

3. https://github.com/junegunn/vim-plug

4. https://www.youtube.com/watch?v=5-aK2_WwrmM
 
# Licencia
 
GNU General Public License.
