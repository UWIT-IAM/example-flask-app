import os

from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/", methods=("GET",))
def index():
    print("Hello there")
    return 'OK', 200


APP_VERSION = None

@app.route("/status")
def status():
    global APP_VERSION
    if APP_VERSION is None:
        APP_VERSION = importlib_metadata.version("${template:app_name}")

    deployment_id = os.environ.get("DEPLOYMENT_ID")
    status = 200 if deployment_id else 503

    return jsonify({"deployment_id": deployment_id, "version": APP_VERSION}), status


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
