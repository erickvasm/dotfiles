#!/bin/bash

# Mostrar ayuda
show_help() {
  echo "Uso: $0 [opciones] archivo1 archivo2 ..."
  echo
  echo "Opciones:"
  echo "  --help           Muestra esta ayuda."
  echo "  --crf [valor]    Establece el valor CRF para la compresión (por defecto: 28)."
  echo "  --scale [res]    Cambia la resolución (ejemplo: 1280:720)."
  echo "  --speed [nivel]  Establece la velocidad del preset (por defecto: slow)."
  echo
  echo "Ejemplos:"
  echo "  $0 clase1.MP4 clase2.MP4"
  echo "  $0 --crf 24 --scale 1280:720 --speed fast clase1.MP4 clase2.MP4"
}

# Valores por defecto
CRF=28
SCALE=""
SPEED="slow"
FILES=()

# Parsear argumentos
while [[ $# -gt 0 ]]; do
  case "$1" in
  --help)
    show_help
    exit 0
    ;;
  --crf)
    CRF="$2"
    shift 2
    ;;
  --scale)
    SCALE="$2"
    shift 2
    ;;
  --speed)
    SPEED="$2"
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
  echo "⚠️  No se especificaron archivos. Usa --help para ver cómo usar el script."
  exit 1
fi

# Procesar cada archivo
for FILE in "${FILES[@]}"; do
  BASENAME=$(basename "$FILE")
  EXT="${BASENAME##*.}"
  NAME="${BASENAME%.*}"
  OUTPUT="${NAME}_comprimido.mp4"

  echo "📦 Comprimiendo '$FILE' → '$OUTPUT'..."
  echo "   CRF: $CRF | Scale: ${SCALE:-original} | Speed: $SPEED"

  if [ -n "$SCALE" ]; then
    ffmpeg -i "$FILE" -vf scale=$SCALE -vcodec libx264 -crf "$CRF" -preset "$SPEED" -acodec aac -b:a 128k "$OUTPUT"
  else
    ffmpeg -i "$FILE" -vcodec libx264 -crf "$CRF" -preset "$SPEED" -acodec aac -b:a 128k "$OUTPUT"
  fi

  echo "✅ Comprimido: $OUTPUT"
  echo
done
