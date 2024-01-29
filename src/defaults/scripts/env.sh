#!/command/with-contenv bash
# shellcheck shell=bash

# By setting an environment variable matching *_FILE to a file path, the prefixed environment
# variable will be overridden with the value specified in that file
redis_env_vars=(
    REDIS_PASSWORD
)

for env_var in "${redis_env_vars[@]}"; do
    file_env_var="${env_var}__FILE"
    if [[ -n "${!file_env_var:-}" ]]; then
        if [[ -r "${!file_env_var:-}" ]]; then
            export "${env_var}=$(< "${!file_env_var}")"
            unset "${file_env_var}"
        else
            echo "==> Skipping export of '${env_var}'. '${!file_env_var:-}' is not readable."
        fi
    fi
done

unset redis_env_vars

export ALLOW_EMPTY_PASSWORD="${ALLOW_EMPTY_PASSWORD:-"no"}"
export REDIS_PASSWORD="${REDIS_PASSWORD:-""}"
