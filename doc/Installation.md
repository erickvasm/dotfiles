# Instalación

## Configuración de una computadora Mac

* Inicia sesión en iCloud y sincroniza todas las contraseñas del Llavero (Keychain).
* Actualiza el sistema operativo de Mac.
* Restaura `~/.ssh` desde iCloud.
* Ejecuta el instalador de dotfiles.
* Inicia sesión en Mail y sincroniza todas las cuentas.
* Ve a `Preferencias/Escritorio y Dock` y activa el ocultamiento automático del dock.
* Ve a `Preferencias/General` y habilita el suavizado de fuentes (si tienes pantalla Retina).
* Abre Safari, ve a `Pestañas` y establece el diseño de pestañas como `Compacto`.
* Descarga AdGuard [Enlace](https://adguard-dns.io/en/public-dns.html).

  * Ve a `Ajustes/General/Elementos de inicio de sesión/` y agrega Rectangle.
* Abre JetBrains Toolbox:

  * Inicia sesión.
  * Habilita "generar scripts de shell en \~/bin".
  * Instala IntelliJ.
  * Instala WebStorm.
* Abre IntelliJ:
  * Importa desde la cuenta de JetBrains.
  * Sincroniza los plugins.
* Abre VS Code:
  * Sincroniza la configuración.
  * Instala la extensión “Settings Sync”.
* Abre iTerm2:
  * Selecciona “cargar preferencias desde URL” y usa `~/.dotfiles/mac/iTerm`. En el siguiente aviso, selecciona “No” para no guardar los cambios.
  * Cambia la fuente y el tema.
* Reinicia la computadora.

Con el script `macos.sh` se configura una Mac nueva con valores predeterminados, pero también puedes usarlo para exportar tu propia configuración:

```bash
./mac-setup.sh export /Users/graifin/.dotfiles/os/mac/settings
```

### Reasignar la tecla Caps Lock

* Reasigna la tecla Caps Lock.
  ![Reasignar Caps Lock](https://i.ibb.co/zXf6R65/Screenshot-2024-01-01-at-2-01-45-PM.png)

* Reasigna `Pegar y coincidir estilo` a `Cmd + Shift + V`.
  ![Reasignar Pegado](https://i.ibb.co/XbNSHCt/Screenshot-2024-01-06-at-8-53-52-PM.png)

* Todas las teclas para windows manager.
![Reasignar Teclas](https://i.ibb.co/C3F3sP6N/Screenshot-2025-05-09-at-21-40-16.png)

---

## Configuración de una computadora Linux

Es igual que en MacOS pero sin la parte de iCloud.

* Para configurar Ubuntu, puedes leer este artículo:
  [Ubuntu](https://medium.com/@erickvasm/ubuntu-setup-29323c81a258)
* Para gestionar las contraseñas uso **Bitwarden**.

---

## Configuración de una computadora con Windows

* Desinstala OneDrive.
* Uso el plugin de iCloud para sincronizar contraseñas.
* Limpia la barra de tareas dejando solo el icono de Windows y el de búsqueda, y elimina apps innecesarias.

  * Dejo solo los iconos del navegador, explorador, tienda y terminal.
* Actualiza Microsoft Edge:

  * Inicia sesión en Microsoft Edge.
  * Sincroniza todas las cuentas.
* Invierte la dirección del scroll y el mapeo de teclas (como en Mac).

  * [Referencias](https://superuser.com/questions/543971/how-to-change-the-windows-alttab-hotkey-to-something-else/1588228#1588228)
* Instala [JetBrains](https://www.jetbrains.com/toolbox-app/)

---

1. Primero debes instalar el instalador de apps en la tienda [winget](https://apps.microsoft.com/detail/9nblggh4nns1?rtc=1&hl=es-cr&gl=CR).
2. Luego instala `winget`.
3. Después instala la CLI de Git:

```bash
winget install --id GitHub.cli
```

4. Luego clona el repositorio y renómbralo como `.dotfiles`.
5. Después descarga PowerShell y Windows Terminal.

Ejecuta como administrador:

```bash
cd .dotfiles/os/windows
./windows.ps1
```

**Nota:** Si el script no está marcado como ejecutable, podrías recibir un error al tratar de ejecutarlo. Para solucionarlo, usa este comando para habilitarlo:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

o

PS C:\path\to\script> Set-ExecutionPolicy Unrestricted
```

* Ejecuta `symlink.ps1` como administrador.
* Importa la configuración del Terminal.

---

### Configurar el comportamiento de la tapa del portátil

* Ve a `Preferencias/Energía` y configura que al cerrar la tapa no se haga nada.
  ![Configurar tapa](https://i.ibb.co/YjnzHvX/Screenshot-2024-01-02-221952.png "Setup")

---

### Directorios importantes a conocer

```powershell
Usuarios > NombreUsuario > .config > powershell

Usuarios > NombreUsuario > Documentos > PowerShell

Usuarios > NombreUsuario > AppData > Local > nvim
```

