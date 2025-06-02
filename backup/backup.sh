#!/usr/bin/env bash
set -e

echo "[backup] Iniciando bucle de copia (cada 120 s)..."

# Puedes ajustar el listados de hostnames si cambian
HOSTS=(maquina1 maquina2 maquina3)

while true; do
  for host in "${HOSTS[@]}"; do
    echo "[backup] ====> Sincronizando desde $host"
    rsync -az --ignore-existing -e "ssh -o StrictHostKeyChecking=no" \
      root@"$host":/home/users/documentos/ "/home/$host/"
  done
  echo "[backup] Esperando 120 s..."
  sleep 120
done