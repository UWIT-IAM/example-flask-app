# Flask app template repository

This is the README for a template you can use to create a repository.
If you follow the instructions, this README will get overwritten by
a README that is more appropriate for your application.

## Creating a repository from this template

If you are reading this from the Github UI,
click the button above that says "Use this template"

You will be asked to name your new repository. To take full advantage
of the automation and kubernetes capabilities, you should create your new
repository under the "UWIT-IAM" namespace; this gives you access to
secrets that are consumable in your Github actions.

Once you have done that, follow the instructions for
[finalizing your template](#finalizing-your-template).

## Finalizing your template

If you are reading this, and you are not in the `flask-example` template repository,
then you haven't yet finalized your template!

To finalize the template, visit your repository on GitHub,
then click on "Actions."

Click the "Finalize Template" workflow, and click "Run this workflow."

A pull request will be generated for you to review and merge! This message will
self-destruct after running that workflow.

## Updating the template

This very basic templating engine does not allow for conditional logic.

To use an argument name inside a document, make sure the document is named `<name>.
template.<ext>`, the final file name will be `<name>.<ext>`.

You can use any supported argument with the format: `${template:<arg_name>}`; all
values are treated as strings.

Functionally:

```
# foo.template.yaml

- policy-name: ${template:app_name_hyphen}-policy
```

becomes:

```
# foo.yaml

- policy-name: my-cool-app-policy
```


### About templating templates...

Please note that `.template.` files are interpolated before any other templating
engine does anything; you may freely nest the `${template:<arg_name>}` syntax inside
other strings that other templating engines might use.

## Supported Values

The currently supported arguments are:

- `app_name`: The name the user wants to give the application created from this template
- `maintainer`: The default maintainer for this new application

## Add support for a new argument:

To support a new value:

- [ ] Add it to the list above ☝️
- [ ] Add it to the argument list in `scripts/finalize-template.py`
- [ ] Add it to the [Finalize Template workflow](.github/workflows/finalize-template.yaml)
      inputs; ensure it is passed into the `finalize-template.py` script.
