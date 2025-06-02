FROM alpine:3.20

RUN apk add --no-cache openssh-client rsync bash coreutils

# Copiamos clave privada generada externamente (match con .pub en maquinas)
COPY keys/backup_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Copia script y dale permisos
COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

CMD ["bash", "/usr/local/bin/backup.sh"]