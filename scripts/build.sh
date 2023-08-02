#!/usr/bin/env bash

# `fingerprinter -o build-script` will always output the absolute path to this script
# https://github.com/UWIT-IAM/fingerprinter/blob/main/fingerprinter/build.sh
$(poetry run fingerprinter -o build-script) -p $@
