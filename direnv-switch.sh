#!/usr/bin/env bash
# https://github.com/direnv/direnv/issues/544 
# Usage: direnv-switch <env-name>
set -euo pipefail

# take the env as the first argument
env_name=$1
env_file=.envrc.${env_name}

# check if the .env.$env_name exists
if [[ ! -f $env_file ]]; then
  echo "env $env_name not found" >&2
  exit 1
fi

# create a new .envrc for the user
cat <<NEW_ENVRC > .envrc
echo "Loading environment "$env_name""
dotenv "$env_file"
NEW_ENVRC
# allow the execution
direnv allow .