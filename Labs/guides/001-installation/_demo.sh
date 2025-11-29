#!/usr/bin/env bash
# 001-Installation — CI-friendly demo script (placeholder)
set -euo pipefail
IFS=$'\n\t'

MODULE="001-Installation"
DEMO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
info(){ printf '[%s] %s\n' "$MODULE" "$*"; }
warn(){ printf '[%s] WARN: %s\n' "$MODULE" "$*" >&2; }

ci_checks(){
  info "CI placeholder: check oc & package tooling presence"
  if command -v oc >/dev/null 2>&1; then
    info "oc: present"
    oc version --client || true
  else
    warn "oc: not in PATH"
  fi
  if command -v helm >/dev/null 2>&1; then
    info "helm: present"
  else
    warn "helm: not found"
  fi
}

case "${1:-}" in
  demo) ci_checks ;;
  *) printf 'Usage: %s demo\n' "$0" ; exit 1 ;;
esac

