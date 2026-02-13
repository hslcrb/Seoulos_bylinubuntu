#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
BRANDING_DIR="${ROOT_DIR}/branding"

if [[ ! -d "${BRANDING_DIR}" ]]; then
  echo "Branding dir not found: ${BRANDING_DIR}" >&2
  exit 1
fi

install -m 0644 "${BRANDING_DIR}/os-release" /etc/os-release
install -m 0644 "${BRANDING_DIR}/lsb-release" /etc/lsb-release
install -m 0644 "${BRANDING_DIR}/issue" /etc/issue

if [[ -f /etc/issue.net ]]; then
  install -m 0644 "${BRANDING_DIR}/issue" /etc/issue.net
fi

echo "Applied Seoulos branding."
