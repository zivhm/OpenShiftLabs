#!/usr/bin/env bash
set -euo pipefail
command -v oc >/dev/null 2>&1 && echo "passed" || { echo "oc not installed"; exit 1; }

