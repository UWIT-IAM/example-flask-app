import os

from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/", methods=("GET",))
def index():
    print("Hello there")
    return 'OK', 200

# TODO: Oh no this has to be fixed first.
@app.route("/status")
def status():
    deployment_id = os.environ.get('DEPLOYMENT_ID')
    return jsonify({
        'deploymentId': deployment_id
    }), 200 if deployment_id else 503


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
