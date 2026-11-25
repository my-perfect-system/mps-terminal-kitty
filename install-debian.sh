#!/usr/bin/env bash
# Install mps-terminal-kitty system packages on Debian (apt). Idempotent.
# Toggles (defaults match the odem.terminal.kitty role):
#   MPS_KITTY_ENABLE_PACKAGES / MPS_KITTY_ENABLE_ALTERNATIVES
set -euo pipefail

ENABLE_PACKAGES="${MPS_KITTY_ENABLE_PACKAGES:-1}"
ENABLE_ALTERNATIVES="${MPS_KITTY_ENABLE_ALTERNATIVES:-1}"

SUDO=""
[[ ${EUID} -eq 0 ]] || SUDO="sudo"

if [[ "${ENABLE_PACKAGES}" = 1 ]]; then
    ${SUDO} apt-get install -y kitty
fi
# Mirrors kitty_enable_alternatives in the odem role.
if [[ "${ENABLE_ALTERNATIVES}" = 1 ]]; then
    ${SUDO} update-alternatives --set x-terminal-emulator /usr/bin/kitty \
        || echo "==> WARN: x-terminal-emulator alternative not set"
fi
echo "mps-terminal-kitty packages installed (debian)."
