# maquinas/maquina-base.Dockerfile
FROM alpine:3.20

# Herramientas básicas: servidor SSH, rsync y bash
RUN apk add --no-cache openssh rsync bash

# Claves de host para SSH (imprescindible)
RUN ssh-keygen -A

# Prepara directorio SSH (la clave pública se copiará luego)
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# Carpeta solicitada por la consigna
RUN mkdir -p /home/users/documentos

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
