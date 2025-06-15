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
