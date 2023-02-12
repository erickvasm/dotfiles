# Entorno de desarrollo Nvim2
 
 
**Índice**  
- [Imagenes](#imagenes)
- [Configuración](#configuracion)
  - [Requerimientos](#requerimientos)
  - [Fuente](#fuentes)
    - [Instalar WSL2](#wsl2)
    - [Instalar Ubuntu](#ubuntu)
- [Nvim](#nvim)
  - [Clonar](#clonar)
  - [Instalar Vim-Plug](#vim-plug)
    - [Instalar Coc](instalar-coc)
    - [Treesitter](#treesitter)
  - [Configuración de Pluggins](#configuración-de-pluggins)
- [Alias](aAlias)
- [Referencias](#referencias)
- [Licencia](#licencia)
 
-------- 
Este es mi archivo personalizado para el editor [Nvim](https://neovim.io/), esta configurado en WSL2. También cuenta con algunas alias para la terminal.
 
Funciona para Ubuntu Linux y MacOS.

-------------- 
# Imagenes
![](https://i.ibb.co/df3YpSB/ejem1.png)
 
 
![](https://i.ibb.co/Tm44PXx/ejem2.png)
 
 
# Configuracion


## Requerimientos

1. python and pip
2. node
3. Neovim
4. gem install neovim
5. npm install -g neovim

## Fuentes
 
Personalmente recomiendo instalar la fuente [JetbrainsMono](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Lekton.zip), para realizarlo, descargamos  la fuente en la página. Sin embargo, si deseas otra fuente, puedes  ingresar a la página oficial de [NerdFonts](https://www.nerdfonts.com/font-downloads).
 
### WSL2
 
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
 
# NVIM
 
Para comprender los comandos personalizados, te recomiendo leer detenidamente cada uno, se pueden modificar a tus preferencias.
 
![](https://i.ibb.co/zn128JV/settings.png) 

Primero instalamos Neovim

```sh
sudo apt install neovim
```
 
## Clonar
 
Algunas veces actualizo el repositorio. Si deseas recibir los cambios, realiza lo siguiente.
 
```sh
git clone (URL de este repositorio)
 
cp init.vim ~/.config/nvim/
```
 
## Vim-Plug 
[vim-plug](https://github.com/junegunn/vim-plug)


Ejecútese para instalar los complementos en el init.vim.
 
* Instalar plugins: ':PlugInstall'
* Actualizar plugins: ':PlugUpdate'
* Eliminar plugins no utilizados: ':PlugClean'
* Actualizar vim-plug en sí: ':PlugUpgrade'

### Instalar coc

Recomiendo personalmente instalar estos plugins de coc. Se instala con el comando ```:CocInstall```

* coc-emmet  

  Para selecionar la opción que se nos puestra es con: *Ctrl y*.

* coc-html-css-support
* coc-pairs
* coc-json 
* coc-tsserver
* coc-prettier
* @yaegassy/coc-volar
* @yaegassy/coc-volar-tools
* @yaegassy/coc-tailwindcss3

### Treesitter 

Recomiendo personalmente instalar estos plugins de Treesitter, igual para Mason. Se instala con el comando ```:TSInstall```

* astro
* java
* javascript
* json
* markdown
* php

## Configuración de Pluggins

### COPILOT
```:Copilot setup```

### Recomendaciones
```:health ```

### Blamer
```:BlamerShow ```

### NERDTRee
1. ma - agregar arhivo
2. md - eliminar archivo 


# Extras

```sh
npm install -g live-server

```
# Alias
 
Esto se debe colocar en el archivo `.zshrc` o `bashrc`

 
```sh
alias vim='nvim'
```
 
# Referencias
 
1. https://github.com/Optixal/neovim-init.vim
 
# Licencia
 
GNU General Public License.
