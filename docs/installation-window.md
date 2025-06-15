# Configuración de una computadora con Windows

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

