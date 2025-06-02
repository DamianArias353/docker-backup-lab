# maquinas/maquina-base.Dockerfile
FROM alpine:3.20

# Herramientas básicas: servidor SSH, rsync y bash
RUN apk add --no-cache openssh rsync bash

# Claves de host para SSH (imprescindible)
RUN ssh-keygen -A

# Configuramos acceso SSH root por clave pública
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config && \
    echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config

    
# Prepara directorio SSH (la clave pública se copiará luego)
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
COPY keys/backup_rsa.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# Carpeta solicitada por la consigna
RUN mkdir -p /home/users/documentos

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
