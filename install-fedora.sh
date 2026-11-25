#!/usr/bin/env bash
# Install mps-terminal-kitty system packages on Fedora (dnf). Idempotent.
# Toggles (defaults match the odem.terminal.kitty role):
#   MPS_KITTY_ENABLE_PACKAGES
set -euo pipefail

ENABLE_PACKAGES="${MPS_KITTY_ENABLE_PACKAGES:-1}"

SUDO=""
[[ ${EUID} -eq 0 ]] || SUDO="sudo"

if [[ "${ENABLE_PACKAGES}" = 1 ]]; then
    ${SUDO} dnf install -y kitty
fi
echo "mps-terminal-kitty packages installed (fedora)."
