# Flask app template repository 

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

**(Optionally, but preferably) Change the `example_app` directory name.** 
While this default name will work, it is 
not very descriptive and may make debugging more difficult. 

**If you changed the `example_app` directory name, update the `APP_MODULE` argument 
in the dockerfile to match.

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

## Build the app

This app uses the [uw-it-build-fingerprinter](https://github.com/uwit-iam/fingerprinter),
the configuration lives in [fingerprints.yaml](fingerprints.yaml). The repository
documentation details how this configuration works.

This requires docker, and assumes you have already run `poetry install`.

To build the app:

```
./scripts/build.sh
```

Use `--help` for more options.


## Deploy

Substitute `dev` with some other stage, if you prefer.

### Deploy the existing code base to dev using a test tag

```bash
./scripts/build.sh --deploy dev --release $(poetry version -s).local.$(whoami)
```

### Deploy a previously tagged version to dev

```bash
./scripts/build.sh --deploy dev -dversion $(poetry version -s)
```

# Common workflows

## Build and cache layers with additional tags

```
./scripts/build.sh -t extra-tag --cache
```

## Create a release version that can be deployed

```
./scripts/build.sh --release $(poetry version -s)
```
