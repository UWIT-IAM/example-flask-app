FROM ghcr.io/uwit-iam/poetry:latest AS dependencies
WORKDIR /app
COPY poetry.lock pyproject.toml ./
RUN poetry install --no-dev --no-root --no-interaction

FROM dependencies AS app
# If you change your app directory, you must also
# change the APP_MODULE here to match. Alternativel,
# you can also
# pass it into your build using `--build-arg`
# (see official docker documentation).
ARG APP_MODULE=example_app
ARG FLASK_PORT=5000
ENV FLASK_ENV=development \
    PYTHONPATH=${APP_MODULE} \
    FLASK_APP=${APP_MODULE}.app
EXPOSE ${FLASK_PORT}
COPY ${APP_MODULE}/ ./${APP_MODULE}
# install root package now that we've copied it
# we depend on the metadata for the package to return the version
RUN poetry install --only-root
ENTRYPOINT ["flask", "run"]

FROM app AS tests
WORKDIR tests/
COPY tests/ ./tests/
ENV PYTHONPATH="/app"
RUN poetry install --no-root --no-interaction  # Install dev dependencies
ENTRYPOINT ["pytest"]
