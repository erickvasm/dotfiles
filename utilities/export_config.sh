#!/bin/bash

# Script para exportar node globab module, python y brew file

# Crear carpeta de exportación
mkdir -p export_logs

echo "[*] Verificando si Volta está instalado..."
if command -v volta &>/dev/null; then
  echo "[*] Volta detectado. Exportando herramientas globales con Volta..."
  volta list >export_logs/volta_globals.txt
else
  echo "[*] Volta no está instalado. Usando npm clásico para listar paquetes globales..."
  npm list -g --depth=0 >export_logs/npm_global_packages.txt 2>&1
  echo "[*] Exportando binarios globales de npm..."
  if npm_bin_path=$(npm bin -g 2>/dev/null); then
    ls -la "$npm_bin_path" >export_logs/npm_global_bins.txt
  else
    echo "No se pudo obtener la ruta de binarios globales de npm." >export_logs/npm_global_bins.txt
  fi
fi

echo "[*] Exportando paquetes globales de pip o pip3..."
if command -v pip &>/dev/null; then
  pip list >export_logs/pip_global_packages.txt
elif command -v pip3 &>/dev/null; then
  pip3 list >export_logs/pip_global_packages.txt
else
  echo "pip/pip3 no encontrado. No se exportaron paquetes de Python." >export_logs/pip_global_packages.txt
fi

echo "[*] Exportando propiedades de Gradle..."
if [ -f "./gradlew" ]; then
  ./gradlew properties >export_logs/gradle_properties.txt 2>&1
else
  echo "gradlew no encontrado en el directorio actual." >export_logs/gradle_properties.txt
fi

echo "[*] Exportando Brewfile..."
if command -v brew &>/dev/null; then
  brew bundle dump --file=export_logs/Brewfile --force
else
  echo "Homebrew no está instalado o no está en el PATH." >export_logs/Brewfile
fi

echo "Exportación completada. Archivos guardados en 'export_logs/'"
