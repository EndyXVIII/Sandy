#!/usr/bin/env bash
# Riduce i video per il web (H.264, AAC, avvio rapido). Richiede ffmpeg (brew install ffmpeg).
# Uso:  bash tools/comprimi-video.sh cartella_con_i_video
# I file ridotti vengono salvati in  <cartella>/ridotti/
set -eu
DIR="${1:-.}"
OUT="$DIR/ridotti"
mkdir -p "$OUT"
shopt -s nullglob nocaseglob
for f in "$DIR"/*.mp4 "$DIR"/*.mov; do
  nome="$(basename "${f%.*}" | tr '[:upper:]' '[:lower:]')"
  echo "→ $nome"
  ffmpeg -loglevel error -y -i "$f" \
    -vf "scale='if(gt(iw,ih),min(960,iw),min(540,iw))':-2" \
    -c:v libx264 -crf 28 -preset slow -pix_fmt yuv420p \
    -c:a aac -b:a 96k -movflags +faststart \
    "$OUT/$nome.mp4"
done
echo; ls -lh "$OUT"
