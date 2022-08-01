# Flask app template repository 

A barebones flask app that can be run as a docker container and deployed to 
a running kubernetes cluster.

## Template Finalization Checklist

If this is now the README.md of your repository, congratulations, you've
"finalized" it to the best of automation's ability. Finish up 
by following these steps:

- [ ] Follow the instructions in [kubernetes-config/README](kubernetes-config/README.md)
  to make your app deployable when ready.
- [ ] Delete the `kubernetes-config` directory
- [ ] Review the workflows in [.github/.workflow](.github/workflows) and look for the
    "UPDATE" string; this indicates you can configure your workflow based on your needs;
    some automation may not function unti you do this.
- [ ] Rename the `example_app` directory to something more indicative of your 
  service's name or function.
- [ ] Delete this section of the README.

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

or, without docker: `poetry run pytest`

## Build the app

This app uses the [uw-it-build-fingerprinter](https://github.com/uwit-iam/fingerprinter),
the configuration lives in [fingerprints.yaml](fingerprints.template.yaml). The repository
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

### Resources:

- [Google Container Repository](https://gcr.io/uwit-mci-iam)
- 
