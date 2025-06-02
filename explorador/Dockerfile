FROM python:3.12-slim

RUN pip install flask

# Copiamos scripts y app
COPY explorer.sh /usr/local/bin/explorer.sh
COPY app.py /app/app.py

RUN chmod +x /usr/local/bin/explorer.sh
WORKDIR /app

CMD ["bash", "/usr/local/bin/explorer.sh"]