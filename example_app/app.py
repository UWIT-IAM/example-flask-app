import os

from flask import Flask, jsonify

app = Flask("example_app")


@app.route("/", methods=("GET",))
def index():
    return 'OK', 200


@app.route("/status")
def status():
    deployment_id = os.environ.get('DEPLOYMENT_ID')
    return jsonify({
        'deploymentId': deployment_id
    }), 200 if deployment_id else 503


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
