#!/bin/bash

show_help() {
  echo "Uso: $0 [opciones] archivo1 archivo2 ..."
  echo
  echo "Opciones:"
  echo "  --help             Muestra esta ayuda."
  echo "  --format [fmt]     Formato destino (por defecto: webp)."
  echo "  --quality [valor]  Calidad de salida (por defecto: 85)."
  echo "  --output-dir [dir] Carpeta de salida (por defecto: misma carpeta del archivo)."
  echo
  echo "Formatos soportados: webp, avif, jpg, jpeg, png, gif"
  echo
  echo "Ejemplos:"
  echo "  $0 imagen.jpg                        → imagen.webp"
  echo "  $0 --format avif imagen.jpg          → imagen.avif"
  echo "  $0 --format png --quality 95 foto.webp"
  echo "  $0 --format webp *.jpg               → convierte todos los JPG"
  echo "  $0 --output-dir ./out --format webp *.jpg"
}

# Valores por defecto
FORMAT="webp"
QUALITY=85
OUTPUT_DIR=""
FILES=()
USING_DEFAULTS=true

# Parsear argumentos
while [[ $# -gt 0 ]]; do
  case "$1" in
  --help)
    show_help
    exit 0
    ;;
  --format)
    FORMAT="${2,,}"
    USING_DEFAULTS=false
    shift 2
    ;;
  --quality)
    QUALITY="$2"
    USING_DEFAULTS=false
    shift 2
    ;;
  --output-dir)
    OUTPUT_DIR="$2"
    USING_DEFAULTS=false
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

# Mostrar defaults si no se pasaron opciones
if [ "$USING_DEFAULTS" = true ]; then
  echo "Usando parámetros por defecto:"
  echo "  --format  $FORMAT"
  echo "  --quality $QUALITY"
  echo
fi

# Verificar ImageMagick
if ! command -v convert > /dev/null 2>&1; then
  echo "ImageMagick (convert) no está instalado. Instala con: brew install imagemagick"
  exit 1
fi

# Validar formato destino
VALID_FORMATS="webp avif jpg jpeg png gif"
if ! echo "$VALID_FORMATS" | grep -qw "$FORMAT"; then
  echo "Formato '$FORMAT' no soportado. Formatos válidos: $VALID_FORMATS"
  exit 1
fi

# Crear carpeta de salida si se especificó
if [ -n "$OUTPUT_DIR" ]; then
  mkdir -p "$OUTPUT_DIR"
fi

# Procesar cada archivo
for FILE in "${FILES[@]}"; do
  if [ ! -f "$FILE" ]; then
    echo "Archivo no encontrado: '$FILE', saltando..."
    continue
  fi

  BASENAME=$(basename "$FILE")
  NAME="${BASENAME%.*}"

  if [ -n "$OUTPUT_DIR" ]; then
    OUTPUT="$OUTPUT_DIR/${NAME}.${FORMAT}"
  else
    DIR=$(dirname "$FILE")
    OUTPUT="${DIR}/${NAME}.${FORMAT}"
  fi

  echo "Convirtiendo '$FILE' → '$OUTPUT'..."
  convert "$FILE" -quality "$QUALITY" "$OUTPUT"
  echo "Listo: $OUTPUT"
  echo
done
