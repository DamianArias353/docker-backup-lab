#!/usr/bin/env bash
set -e

HOSTS=(maquina1 maquina2 maquina3)

echo "[backup] Iniciando bucle de rsync (cada 120 s)..."

while true; do
  for host in "${HOSTS[@]}"; do
    echo "[backup] ====> rsync desde $host"
    rsync -az --ignore-existing -e "ssh -o StrictHostKeyChecking=no" \
      root@"$host":/home/users/documentos/ "/home/$host/"
  done
  echo "[backup] Esperando 120 s..."
  sleep 120
done