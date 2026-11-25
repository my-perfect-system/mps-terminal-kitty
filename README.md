# mps-terminal-kitty

Kitty terminal emulator configuration of the [my-perfect-system](https://github.com/my-perfect-system) (mps) terminal stack.

## Install

| Method | Description |
|---|---|
| Default | `bootstrap.sh` clones to the system-wide mps repo dir and runs `install.sh` |
| Ansible | can be used by installing via the `odem.terminal.kitty` role of [odem-terminal](https://github.com/my-perfect-system/odem-terminal) |
| Standalone | clone the repo, then run `./install.sh` inside it; no network needed |

### Install (Default)

```bash
curl -fsSL https://raw.githubusercontent.com/my-perfect-system/mps-terminal-kitty/main/bootstrap.sh | bash
```

All methods deploy `config/kitty` to the current user's `~/.config/kitty`. One
clone per host (`${MPS_REPO_DIR:-/srv/repo/github/my-perfect-system}`), shared
by all users.

## Usage

```bash
kitty                           # launch the terminal
icat image.png                  # kitty +kitten icat (alias from the alias repo)
cfg-kitty                       # edit ~/.config/kitty/kitty.conf
```
