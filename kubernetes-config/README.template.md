# Template Kubernetes Configuration

The basic kubernetes configuration provided here will subscribe you
to the [basic-web-service helm chart].

After finalizing your template, you should copy the files in this directory
into the [gcp-k8] repository, in the `dev/${template:app_name}` directory.

Unless you change the values generated for you, your app will
expect to run at `https://${template:app_name_hyphen}.iamdev.s.uw.edu`.


[gcp-k8]: https://github.com/uwit-iam/gcp-k8
[basic-web-service helm chart]: https://github.com/uw-iti-app-platform/helm-charts
