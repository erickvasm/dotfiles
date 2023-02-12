Personalizar Terminal 
========================

**Índice**  
- [Windows](#wsl2)
- [Shell ZSH](#zsh)
-  [Fuentes](#fuentes)
    -  [Pasos Windows](#windows)
    -  [Pasos Ubuntu](#ubuntu)
- [Tema transpararente Windows](#color)
- [Pluggins](#pluggins)
-  [Alias](#Alias)
- [Referencias](#referencias)
- [Licencia](#licencia)

- - - - 

Este repositorio es para personalizar la terminal de Ubuntu o de Windows Subsystem for Linux. 

- - - 

## WSL2

Si estas usando Windows, realiza los siguientes pasos. Si estas usando allguna distribución de Debian como Ubuntu, ve al paso de  [Shell ZSH](#zsh)

 
1. Abrimos como administrador PowerShell y ejecutamos el siguiente comando:
 
```sh
wsl --install
```
 
De forma predeterminada, la distribución de Linux instalada será Ubuntu.
 
2. Luego nos solicitará ingresar el nombre de usuario y contraseña.
 
3. Actualizamos los paquetes y listo.
 
```sh
sudo apt update && sudo apt upgrade
```


## ZSH

 
1. Instalar ZSH.
 
```sh
sudo apt install zsh
```
 
2. Hacer ZSH la shell predeterminada.
 
```sh
chsh -s $(which zsh)
```
 
3. Reiniciar terminal.
 
4. Seleccionar opción 0 si pregunta por seleccionar un item.
 
5. Verificar Shell: `echo $SHELL`, debería mostrar ->  `/usr/bin/zsh`
 
6. Instalamos Oh My Zsh
 
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
 
7. Instalamos PowerLevel10k Theme
 
```
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```
 
8. Descargamos algunos pluggins
 
```
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```
 
9. Editamos el archivo `~/.zshrc`
 
* Buscamos la sección de `ZSH_THEME` y reemplazamos lo siguiente:
 
```sh
ZSH_THEME="powerlevel10k/powerlevel10k"
```
 
* Agregar la siguiente línea para usar Nerd Pached:
 
```sh
POWERLEVEL9K_MODE="nerdfont-complete"
```
 
* Si quieres autocompletado habilita la siguiente opción:
 
```sh
#ENABLE_CORRECTION="true"
//Asi
ENABLE_CORRECTION="true"
```
 
10. Por ultimo, remplazamos `plugins=(git)` por `plugins=(git zsh-autosuggestions zsh-syntax-highlighting)`

## Fuentes
 
Personalmente recomiendo instalar la fuente [JetbrainsMono](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Lekton.zip), para realizarlo, descargamos  la fuente en la página. Sin embargo, si deseas otra fuente, puedes  ingresar a la página oficial de [NerdFonts](https://www.nerdfonts.com/font-downloads).
 
### Windows
 
1. Descargar la fuente de preferencia en la página oficial de NerdFonts
 
2. Descomprimir **.zip**
 

3. Seleccionar todos los archivos y presionar la opción de *Instalar para todos los usuarios*
 
![](https://i.ibb.co/SPfBR96/selecionar-Fo.png)
 
4. Seleccionar la fuente en la configuración en Windows Terminal.
 
![](https://i.ibb.co/64516j3/fonts-Terminal.png)

### Ubuntu

1. Descargar la fuente de preferencia en la página oficial de NerdFonts
 
2. Descomprimir **.zip**

3. Seleccionar la fuente normal y presionar la opción de *Instalar*
  
4. Seleccionar la fuente en las preferencias de la terminal de Ubuntu.
 
![](https://i.ibb.co/H4kWKZc/Ubuntu-Font.png)

## Color
 
Existen distintas maneras para poder personalizar la terminal. Desde colores, imágenes de fondos y mucho más.
 
En mi caso, me gusto el efecto transparente, por eso es la que explicaré a continuación:
 
1. Abrimos el **.json de la terminal**
 
![](https://i.ibb.co/BTnvvFg/json.png)
 
2. En la sección donde se ubican las configuraciones del Perfil de Ubuntu, pegamos lo siguiente:
 
```json
            {
                "acrylicOpacity": 0.69999999999999996,
                "colorScheme": "Frost-Dark",
                "cursorColor": "#FFFFFF",
                "font":
                {
                    "face": "JetBrainsMono Nerd Font"
                },
                "guid": "{2c4de342-38b7-51cf-b940-2309a097f518}",
                "hidden": false,
                "name": "Ubuntu",
                "source": "Windows.Terminal.Wsl",
                "useAcrylic": true
            }
```
 
Cabe aclarar, que la fuente en mi caso es JetBrainsMono, aquí la debes cambiar por la de tu preferencia.
 
3. En la sección de **schemes**, pegamos lo siguiente:
 
- ***Tema transparente claro***
 
```json
{
            "background": "#FFFFFF",
            "black": "#3C5712",
            "blue": "#17B2FF",
            "brightBlack": "#749B36",
            "brightBlue": "#27B2F6",
            "brightCyan": "#13A8C0",
            "brightGreen": "#89AF50",
            "brightPurple": "#F2A20A",
            "brightRed": "#F49B36",
            "brightWhite": "#741274",
            "brightYellow": "#991070",
            "cursorColor": "#FFFFFF",
            "cyan": "#3C96A6",
            "foreground": "#000000",
            "green": "#6AAE08",
            "name": "Frost",
            "purple": "#991070",
            "red": "#8D0C0C",
            "selectionBackground": "#FFFFFF",
            "white": "#6E386E",
            "yellow": "#991070"
        }
```
 
- ***Tema transparente oscuro***
 
```json
        {
            "background": "#000000",
            "black": "#3C5712",
            "blue": "#17B2FF",
            "brightBlack": "#749B36",
            "brightBlue": "#27B2F6",
            "brightCyan": "#13A8C0",
            "brightGreen": "#89AF50",
            "brightPurple": "#F2A20A",
            "brightRed": "#F49B36",
            "brightWhite": "#741274",
            "brightYellow": "#991070",
            "cursorColor": "#FFFFFF",
            "cyan": "#3C96A6",
            "foreground": "#FFFFFF",
            "green": "#6AAE08",
            "name": "Frost-Dark",
            "purple": "#991070",
            "red": "#8D0C0C",
            "selectionBackground": "#FFFFFF",
            "white": "#6E386E",
            "yellow": "#991070"
        }
```
 
Para mas temas, puedes buscar en [Aqui](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes)
 

## Pluggins

### FZF
FZF es un pluggin para buscar cualquier archivo y directorio en la terminal. Funciona para WSL2 y Ubuntu. 

Puedes revisar la documentación oficial [Aquí](https://github.com/junegunn/fzf)

1. Clonar el repositorio
```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

~/.fzf/install
```
2. Comandos
* ctrl + r = buscar en el historial
* ctrl + t = buscar en el directorio actual

### Iconos de archivos

```sh
sudo apt-get install ubuntu-dev-tools
sudo apt install -y ruby ruby-dev ruby-colorize
sudo apt-get install -y libncurses5-dev libtinfo-dev
sudo gem install colorls

colorls -r
```  

Agregar las siguiente lineas en el archivo `~/.zshrc`. O simplemente clona este repositorio y copia mi arhivo  `~/.zshrc`

```sh
### LS & TREE
alias ll='ls -la'
alias la='ls -A'
alias l='ls -F'
command -v lsd > /dev/null && alias ls='lsd --group-dirs first' && \
	alias tree='lsd --tree'
command -v colorls > /dev/null && alias ls='colorls --sd --gs' && \
	alias tree='colorls --tree'
```

## Alias

```sh
alias vim='nvim'
alias ..='cd ..'
alias c='clear'
alias ...='cd ../../'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias update='sudo apt update && sudo apt upgrade'
alias h='history'
alias path='echo $PATH | tr : \\n'
alias gpo='git push origin'
alias gpo='git pull origin'
```
 
## Referencias
1. https://medium.com/@shivam1/make-your-terminal-beautiful-and-fast-with-zsh-shell-and-powerlevel10k-6484461c6efb
 
##  Licencia
 
GNU General Public License.
