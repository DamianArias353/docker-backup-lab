FROM alpine:3.20

RUN apk add --no-cache openssh-client rsync bash coreutils

# Generamos par de claves en build (simple para demo)
RUN mkdir -p /root/.ssh && \
    ssh-keygen -q -t rsa -N "" -f /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa

# Copia script y dale permisos
COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

CMD ["bash", "/usr/local/bin/backup.sh"]