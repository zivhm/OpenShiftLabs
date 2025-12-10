#!/usr/bin/env bash
set -euo pipefail

# Pass if setup marker exists in $HOME or oc is available
if [[ -f "$HOME/.openshift_setup_done" ]] || command -v oc >/dev/null 2>&1; then
	echo "passed"
else
	echo "Setup not completed. Run the setup command from the step." >&2
	exit 1
fi

