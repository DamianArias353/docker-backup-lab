#!/usr/bin/env bash
set -e

# Lanza Flask en segundo plano
python app.py &

# Bucle cada 60 s buscando “Alarma” (dejamos TODO para después)
while true; do
  echo "[explorador] Escaneo placeholder..."
  sleep 60
done