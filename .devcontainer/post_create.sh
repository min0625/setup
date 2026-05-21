#!/bin/bash

# Abort on errors.
set -eo pipefail

# Abort on unset variables.
set -u

if [[ -f ".devcontainer/post_create.local.sh" ]]; then
	source ".devcontainer/post_create.local.sh"
fi
