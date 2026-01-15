#!/bin/bash

# Mostrar ayuda
show_help() {
  echo "Uso: $0 [opciones] archivo1 archivo2 ..."
  echo
  echo "Opciones:"
  echo "  --help           Muestra esta ayuda."
  echo "  --quality [valor] Establece la calidad para la compresión (por defecto: 80)."
  echo
  echo "Ejemplos:"
  echo "  $0 imagen1.jpg imagen2.png"
  echo "  $0 --quality 70 imagen1.jpg imagen2.png"
}

# Valores por defecto
QUALITY=80
FILES=()

# Parsear argumentos
while [[ $# -gt 0 ]]; do
  case "$1" in
  --help)
    show_help
    exit 0
    ;;
  --quality)
    QUALITY="$2"
    shift 2
    ;;
  *)
    FILES+=("$1")
    shift
    ;;
  esac
done

# Validar archivos
if [ ${#FILES[@]} -eq 0 ]; then
  echo "No se especificaron archivos. Usa --help para ver cómo usar el script."
  exit 1
fi

# Verificar si ImageMagick está instalado
if ! command -v convert > /dev/null 2>&1; then
    echo "ImageMagick (convert) is not installed. Please install it to use this script."
    exit 1
fi

# Procesar cada archivo
for FILE in "${FILES[@]}"; do
  BASENAME=$(basename "$FILE")
  EXT="${BASENAME##*.}"
  NAME="${BASENAME%.*}"
  OUTPUT="${NAME}_comprimido.${EXT}"

  echo "Comprimiendo '$FILE' → '$OUTPUT'..."
  echo "   Quality: $QUALITY"

  convert "$FILE" -quality "$QUALITY" "$OUTPUT"

  echo "Comprimido: $OUTPUT"
  echo
done