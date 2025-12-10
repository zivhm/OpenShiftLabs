#!/usr/bin/env bash
set -euo pipefail

# Pass if setup marker exists or oc is available
if [[ -f /root/.openshift_setup_done ]] || command -v oc >/dev/null 2>&1; then
	echo "passed"
else
	echo "Setup not completed. Run: bash /root/setup.sh" >&2
	exit 1
fi

