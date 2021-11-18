FROM ghcr.io/uwit-iam/poetry:latest AS dependencies
WORKDIR /app
COPY poetry.lock pyproject.toml ./
RUN poetry install --no-dev --no-root --no-interaction

FROM dependencies AS app
ARG FLASK_PORT=5000
ENV FLASK_ENV=development
EXPOSE ${FLASK_PORT}
COPY example_app/ ./example_app/
ENTRYPOINT python example_app/app.py

FROM app AS tests
WORKDIR tests/
COPY tests/ ./tests/
ENV PYTHONPATH="/app"
RUN poetry install --no-root --no-interaction  # Install dev dependencies
ENTRYPOINT ["pytest"]

FROM app AS deployment
ARG DEPLOYMENT_ID=""
ENV DEPLOYMENT_ID="${DEPLOYMENT_ID}"
RUN test -n "${DEPLOYMENT_ID}"  # Require DEPLOYMENT_ID to be provided when building
