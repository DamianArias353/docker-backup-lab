#!/usr/bin/env bash
set -e

echo "[explorador] Lanzando servidor Flask..."
python app.py &

ALERT_LOG="/home/alertas_detectadas/alertas.txt"
mkdir -p /home/alertas_detectadas
touch "$ALERT_LOG"

echo "[explorador] Iniciando escaneo de backups..."

while true; do
  echo "[explorador] Escaneando archivos en /home/backups/maquina*/..."
  for dir in /home/backups/maquina*; do
    [ -d "$dir" ] || continue
    for archivo in "$dir"/*; do
      [ -f "$archivo" ] || continue
      echo "[explorador] Revisando $archivo"
      if grep -iq "Alarma" "$archivo"; then
        hora=$(date +"%H:%M")
        fecha=$(date +"%Y-%m-%d")
        ruta="$archivo"
        total_palabras=$(wc -w < "$archivo")
        palabras_con_a=$(grep -oE '\b\w*a\b' "$archivo" | wc -l)

        if ! grep -q "$ruta" "$ALERT_LOG"; then
          echo "$hora $fecha $ruta $total_palabras $palabras_con_a" >> "$ALERT_LOG"
          echo "[explorador] Alerta detectada en $archivo"
        fi
      fi
    done
  done
  sleep 60
done