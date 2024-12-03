FROM us-docker.pkg.dev/uwit-mci-iam/containers/base-python-3.9:latest AS dependencies

WORKDIR /app
COPY poetry.lock pyproject.toml ./
RUN --mount=type=secret,id=gcloud_auth_credentials \
    md5sum /run/secrets/gcloud_auth_credentials
# get gcloud_auth_credentials secret from docker buildx (put in /run/secrets by default)
# install GAR keyring + setup ENV VAR per docs
# https://pypi.org/project/keyrings.google-artifactregistry-auth/
RUN --mount=type=secret,id=gcloud_auth_credentials \
    poetry self add keyrings.google-artifactregistry-auth && \
    export GOOGLE_APPLICATION_CREDENTIALS=/run/secrets/gcloud_auth_credentials && \
    poetry install --only main --no-root --no-interaction

FROM dependencies AS app

ARG DEPLOYMENT_ID
ARG APP_MODULE=example_app
ARG FLASK_PORT=5000
ENV FLASK_ENV=development \
    PYTHONPATH=${APP_MODULE} \
    FLASK_APP=${APP_MODULE}.app \
    DEPLOYMENT_ID=${DEPLOYMENT_ID}
EXPOSE ${FLASK_PORT}
COPY ${APP_MODULE}/ ./${APP_MODULE}
# install root package now that we've copied it
# we depend on the metadata for the package to return the version
RUN poetry install --only-root
ENTRYPOINT ["poetry", "run", "flask", "run", "--host", "0.0.0.0"]

FROM app AS tests
WORKDIR tests/
COPY tests/ ./tests/
ENV PYTHONPATH="/app"
RUN poetry install --no-root --no-interaction  # Install dev dependencies
ENTRYPOINT ["pytest"]
