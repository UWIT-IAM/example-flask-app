# uwit-iam/flask-example

A barebones flask app that can be run as a docker container and deployed to 
a running kubernetes cluster. Can also be used as a template
repository for creating new apps.

## Using this template

This is a template repository. You can clone it and make a new app with it!
Just click the "Use this template" button from [Github](https://github.
com/uwit-iam/example-flask-app).

Then, you will need to change the following:

**In `pyproject.toml`, change the `name` value.** This value is only 
functionally important if you are publishing your project to PyPI or some other 
python package manager.

**(Optionally) Change the `example_app` directory name.** 
While this default name will work, it is 
not very descriptive and may make debugging more difficult. 

**If you changed the `example_app` directory name, update the `Dockerfile`.
Replace instances of `example_app` in the Dockerfile to match your new directory name.

**Delete this section of the README.md.** Unless you're creating a template repo 
yourself, you should delete these template instructions.

## Requirements

**...to run and test**

- A running docker daemon

**...to deploy and maintain**

- A running docker daemon
- [Poetry](https://python-poetry.org) 

## Run locally


**...with docker**

```bash
docker run -p 5000:5000 -it $(docker build -q --target app .)
```

then visit http://localhost:5000 in your browser.

**...without docker**


```bash
poetry install
FLASK_APP="example_app/app.py" poetry run flask run
```

then visit http://localhost:5000 in your browser.


## Test

```bash
docker run -it $(docker build -q --target tests .)
```

## Deploy

```bash
export DEPLOYMENT_ID="deploy-dev.$(date '+%Y.%m.%d.%H.%M.%S').v$(poetry version -s 2>/dev/null)"
docker build --target deployment --build-arg DEPLOYMENT_ID \
    -t ${YOUR_REPOSITORY}/example-flask-app:${DEPLOYMENT_ID} .
docker push "${YOUR_REPOSITORY}/example-flask-app:${DEPLOYMENT_ID}"
```

where `YOUR_REPOSITORY` is something like: `ghcr.io/uwit-iam`. 
