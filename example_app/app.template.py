import importlib.metadata as importlib_metadata  # Python ^3.9 change

from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/", methods=("GET",))
def index():
    print("Hello there")
    return "OK", 200


APP_VERSION = None


@app.route("/status")
def status():
    global APP_VERSION
    if APP_VERSION is None:
        try:
            APP_VERSION = importlib_metadata.version("${template:app_name_underscore}")
        except importlib_metadata.PackageNotFoundError:
            "Something went wrong locating the package that is this application. Was it installed via poetry?"

    status = 200 if APP_VERSION else 503

    return jsonify({"version": APP_VERSION}), status


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
