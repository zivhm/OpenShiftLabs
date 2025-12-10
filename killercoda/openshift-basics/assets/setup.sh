#!/usr/bin/env bash
set -euo pipefail

# Install dependencies
if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update -y
  sudo apt-get install -y curl jq git
fi

# Install oc CLI (adjust source/version as needed)
if ! command -v oc >/dev/null 2>&1; then
  curl -sSfL https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz -o /tmp/oc.tar.gz
  sudo tar -C /usr/local/bin -xzf /tmp/oc.tar.gz oc kubectl
  sudo chmod +x /usr/local/bin/oc /usr/local/bin/kubectl
fi

echo "Environment ready. Proceed to the labs page."

# Mark completion for verification
touch /root/.openshift_setup_done || true
