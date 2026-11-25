#!/usr/bin/env bash
# Deploy mps-terminal-kitty to the current user's ~/.config/kitty. Idempotent.
# OS-specific packages live in install-debian.sh / install-fedora.sh and are
# installed best-effort before the config deploy.
# Toggles (defaults match the odem.terminal.kitty role):
#   MPS_KITTY_ENABLE_PACKAGES / MPS_KITTY_ENABLE_ALTERNATIVES
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SUDO=""
[[ ${EUID} -eq 0 ]] || SUDO="sudo"

#--- Distro detection -----------------------------------------------------------
detect_distro() {
    local id
    id="$(grep -sE '^ID=' /etc/os-release | head -1 | cut -d= -f2 | tr -d '\"')"
    case "${id}" in
        debian|ubuntu) echo "debian" ;;
        fedora|rhel)   echo "fedora" ;;
        *)
            if command -v apt-get >/dev/null 2>&1; then echo "debian"
            elif command -v dnf >/dev/null 2>&1; then echo "fedora"
            else echo "none"; fi ;;
    esac
}

#--- System: distro packages (best-effort; toggles read by the OS scripts) ---
case "$(detect_distro)" in
    debian) "${SRC}/install-debian.sh" || echo "==> WARN: install-debian.sh failed; continuing" ;;
    fedora)  "${SRC}/install-fedora.sh" || echo "==> WARN: install-fedora.sh failed; continuing" ;;
    *)       echo "==> Unsupported distro — skipping system packages" ;;
esac

#--- Config deploy (mirrors the odem.terminal.kitty role) ------------------------
install -d -m 0700 "${HOME}/.config/kitty"
cp -a "${SRC}/config/kitty/." "${HOME}/.config/kitty/"

echo "mps-terminal-kitty deployed to ${HOME}/.config/kitty. Run: kitty"
