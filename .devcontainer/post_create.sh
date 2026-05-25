#!/bin/bash

# Abort on errors.
set -eo pipefail

# Abort on unset variables.
set -u

if [[ -f ".devcontainer/post_create.local.sh" ]]; then
    # shellcheck disable=SC1091  # Reason: optional local hook may be absent during linting and is loaded only when present.
    source ".devcontainer/post_create.local.sh"
fi
