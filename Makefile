.ONESHELL:

.PHONY: install
install:          ## Install the project in dev mode.
	@./venv/bin/pip install -U pip
	@./venv/bin/pip install --no-input 'urllib3<2' keyring keyrings.google-artifactregistry-auth
	@if ! poetry --version >/dev/null; then pip install poetry ; fi
	@poetry install --with=dev
