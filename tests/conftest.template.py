import pytest
from ${template:app_name}.app import app as flask_app


@pytest.fixture
def app():
    return flask_app
