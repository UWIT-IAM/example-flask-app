#!/bin/bash

export APP_NAME="${template:app_name}"

function get_instance_status {
    local stage="$1"
    local url="https://${APP_NAME}.iam${stage}.s.uw.edu/status"
    curl -sk $url
}

function get_poetry_version {
  cat pyproject.toml | grep 'version =' | cut -f2 -d\" | head -n1
}


function get_promotion_version {
  # provides default values for the application version to deploy
  # dev gets current version of app (presumed newest due to CI process)
  # otherwise promotes dev => eval or eval => prod, depending on target stage
  local target=$1
  case $target in
    dev)
      echo $(get_poetry_version)
      ;;
    eval)
      echo $(get_instance_status dev | jq -r .version)
      ;;
    prod)
      echo $(get_instance_status eval | jq -r .version)
      ;;
  esac
}
