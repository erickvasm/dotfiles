#!/bin/bash

show_help() {
  echo "Uso: $0 [opciones] INPUT OUTPUT"
  echo
  echo "  El formato de salida se detecta por la extensión de OUTPUT."
  echo
  echo "Opciones:"
  echo "  --help             Muestra esta ayuda."
  echo "  --fps [valor]      Fotogramas por segundo (por defecto: auto)."
  echo "  --width [px]       Ancho en px, -1 = original (por defecto: auto)."
  echo "  --start [tiempo]   Inicio en segundos o HH:MM:SS."
  echo "  --duration [seg]   Duración en segundos."
  echo "  --quality [valor]  Calidad: CRF para video, 1-100 para gif/webp (por defecto: auto)."
  echo "  --optimize         Optimizar GIF con gifsicle si está disponible."
  echo
  echo "Formatos soportados:"
  echo "  Salida: gif, mp4, webm, mov, avi, mkv, webp (animado)"
  echo "  Entrada: cualquier formato que soporte ffmpeg"
  echo
  echo "Ejemplos:"
  echo "  $0 video.mp4 output.gif"
  echo "  $0 clip.mov output.mp4"
  echo "  $0 --start 5 --duration 10 --width 480 video.mp4 demo.gif"
  echo "  $0 --fps 30 --quality 20 entrada.mkv salida.mp4"
  echo "  $0 screen.mp4 animated.webp"
}

FPS=""
WIDTH=""
START=""
DURATION=""
QUALITY=""
OPTIMIZE=false
INPUT=""
OUTPUT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
  --help)
    show_help
    exit 0
    ;;
  --fps)      FPS="$2";      shift 2 ;;
  --width)    WIDTH="$2";    shift 2 ;;
  --start)    START="$2";    shift 2 ;;
  --duration) DURATION="$2"; shift 2 ;;
  --quality)  QUALITY="$2";  shift 2 ;;
  --optimize) OPTIMIZE=true; shift ;;
  *)
    if [ -z "$INPUT" ]; then
      INPUT="$1"
    elif [ -z "$OUTPUT" ]; then
      OUTPUT="$1"
    else
      echo "Error: argumento inesperado '$1'. Usa --help."
      exit 1
    fi
    shift
    ;;
  esac
done

if [ -z "$INPUT" ] || [ -z "$OUTPUT" ]; then
  echo "Error: se requiere INPUT y OUTPUT. Usa --help."
  exit 1
fi

if [ ! -f "$INPUT" ]; then
  echo "Error: archivo no encontrado: '$INPUT'"
  exit 1
fi

if ! command -v ffmpeg > /dev/null 2>&1; then
  echo "Error: ffmpeg no está instalado."
  exit 1
fi

EXT="${OUTPUT##*.}"
EXT="${EXT,,}"

TIME_ARGS=()
[ -n "$START" ]    && TIME_ARGS+=(-ss "$START")
[ -n "$DURATION" ] && TIME_ARGS+=(-t "$DURATION")

echo "Convirtiendo '$INPUT' → '$OUTPUT' (formato: $EXT)..."

convert_gif() {
  local fps="${FPS:-15}"
  local width="${WIDTH:-640}"
  local palette
  palette="$(mktemp /tmp/palette_XXXXXX.png)"

  local scale_filter="fps=${fps},scale=${width}:-1:flags=lanczos"

  ffmpeg -y "${TIME_ARGS[@]}" -i "$INPUT" \
    -vf "${scale_filter},palettegen=stats_mode=diff" \
    "$palette" -loglevel error

  ffmpeg -y "${TIME_ARGS[@]}" -i "$INPUT" -i "$palette" \
    -lavfi "${scale_filter} [x]; [x][1:v] paletteuse=dither=bayer:bayer_scale=5" \
    "$OUTPUT" -loglevel error

  rm -f "$palette"

  if [ "$OPTIMIZE" = true ]; then
    if command -v gifsicle > /dev/null 2>&1; then
      echo "   Optimizando con gifsicle..."
      gifsicle -O3 --batch "$OUTPUT"
    else
      echo "   Advertencia: gifsicle no encontrado, --optimize ignorado."
    fi
  fi
}

convert_webp_animated() {
  local fps="${FPS:-15}"
  local width="${WIDTH:--1}"
  local quality="${QUALITY:-80}"
  local vf_args="fps=${fps}"
  [ "$width" != "-1" ] && vf_args="${vf_args},scale=${width}:-1:flags=lanczos"

  ffmpeg -y "${TIME_ARGS[@]}" -i "$INPUT" \
    -vf "$vf_args" \
    -vcodec libwebp -lossless 0 -quality "$quality" -loop 0 \
    "$OUTPUT" -loglevel error
}

convert_mp4() {
  local crf="${QUALITY:-23}"
  local vf_args=""
  [ -n "$WIDTH" ] && vf_args="-vf scale=${WIDTH}:-1"
  local fps_args=""
  [ -n "$FPS" ] && fps_args="-r $FPS"

  ffmpeg -y "${TIME_ARGS[@]}" -i "$INPUT" \
    $vf_args $fps_args \
    -vcodec libx264 -crf "$crf" -preset slow \
    -acodec aac -b:a 128k \
    "$OUTPUT" -loglevel error
}

convert_webm() {
  local crf="${QUALITY:-33}"
  local vf_args=""
  [ -n "$WIDTH" ] && vf_args="-vf scale=${WIDTH}:-1"
  local fps_args=""
  [ -n "$FPS" ] && fps_args="-r $FPS"

  ffmpeg -y "${TIME_ARGS[@]}" -i "$INPUT" \
    $vf_args $fps_args \
    -vcodec libvpx-vp9 -crf "$crf" -b:v 0 \
    -acodec libopus -b:a 128k \
    "$OUTPUT" -loglevel error
}

convert_generic() {
  local vf_args=""
  [ -n "$WIDTH" ] && vf_args="-vf scale=${WIDTH}:-1"
  local fps_args=""
  [ -n "$FPS" ] && fps_args="-r $FPS"

  ffmpeg -y "${TIME_ARGS[@]}" -i "$INPUT" \
    $vf_args $fps_args \
    "$OUTPUT" -loglevel error
}

case "$EXT" in
  gif)  convert_gif ;;
  webp) convert_webp_animated ;;
  mp4)  convert_mp4 ;;
  webm) convert_webm ;;
  mov|avi|mkv|flv|wmv) convert_generic ;;
  *)
    echo "Advertencia: formato '$EXT' no reconocido, intentando conversión genérica..."
    convert_generic
    ;;
esac

if [ $? -eq 0 ] && [ -f "$OUTPUT" ]; then
  SIZE=$(du -sh "$OUTPUT" 2>/dev/null | cut -f1)
  echo "Listo: $OUTPUT ($SIZE)"
else
  echo "Error: conversión falló."
  exit 1
fi
