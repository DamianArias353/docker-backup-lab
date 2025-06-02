from flask import Flask, render_template_string
import os

app = Flask(__name__)

@app.route("/")
def index():
    alert_path = "/home/alertas_detectadas/alertas.txt"
    alert_lines = []
    if os.path.exists(alert_path):
        with open(alert_path, "r") as f:
            alert_lines = f.readlines()

    backup_files = []
    base_dir = "/home"
    for root, dirs, files in os.walk(base_dir):
        for file in files:
            full_path = os.path.join(root, file)
            rel_path = os.path.relpath(full_path, base_dir)
            if not rel_path.startswith("alertas_detectadas"):
                backup_files.append(rel_path)

    return render_template_string("""
        <h1>Explorador en marcha</h1>
        <h2>Archivos respaldados:</h2>
        <ul>
        {% for file in backup_files %}
            <li>{{ file }}</li>
        {% endfor %}
        </ul>
        <h2>Alertas detectadas:</h2>
        <pre>{{ alert_lines | join('') }}</pre>
    """, backup_files=backup_files, alert_lines=alert_lines)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)