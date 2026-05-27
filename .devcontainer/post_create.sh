#!/bin/bash

set -euo pipefail

# Allow git and tools (e.g. pre-commit) to operate in this directory even if
# the workspace is owned by a different user (common in dev containers).
git config --global --add safe.directory "$(pwd)"

# See: https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials
# Configure Git SSH commit signing using the forwarded SSH agent.
# The private key lives on the host; use key:: prefix so no key file is needed.
if command -v ssh-add > /dev/null 2>&1 && ssh-add -l > /dev/null 2>&1; then
    pubkey="$(ssh-add -L | head -1)"
    git config --global user.signingkey "key::${pubkey}"
    git config --global gpg.format "ssh"
    git config --global commit.gpgsign true

    echo "Configured Git signing key from SSH agent."
else
    echo "Warning: No keys found in SSH agent. Git commit signing will not work." >&2
fi

if [[ -f ".devcontainer/post_create.local.sh" ]]; then
    # shellcheck disable=SC1091  # Reason: optional local hook may be absent during linting and is loaded only when present.
    source ".devcontainer/post_create.local.sh"
fi
