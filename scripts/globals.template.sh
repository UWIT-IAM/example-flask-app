#!/bin/bash

export APP_NAME="${template:app_name}"

function get_instance_status {
    local stage="$1"
    # substitute '_' for '-' in APP_NAME
    local url="https://${APP_NAME//_/-}.iam${stage}.s.uw.edu/status"
    curl -sk "$url" || >&2 echo "Failed to check $url"
}

function get_poetry_version {
  grep 'version =' pyproject.toml | cut -f2 -d\" | head -n1
}


function get_promotion_version {
  # provides default values for the application version to deploy
  # dev gets current version of app (presumed newest due to CI process)
  # otherwise promotes dev => eval or eval => prod, depending on target stage
  local target=$1
  case $target in
    dev)
      get_poetry_version
      ;;
    eval)
      get_instance_status dev | jq -r .version
      ;;
    prod)
      get_instance_status eval | jq -r .version
      ;;
  esac
}
