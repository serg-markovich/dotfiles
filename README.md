# dotfiles

Reproducible workstation configuration for Zsh, Git, and VS Code, managed with [chezmoi](https://www.chezmoi.io) and secured with [gitleaks](https://github.com/gitleaks/gitleaks) pre-commit scanning. Built with DevOps principles: one command to bootstrap, no manual setup steps, secrets never committed in plaintext.

## Quick start (new machine)

```bash
sh -c "$(curl -fsLS https://raw.githubusercontent.com/serg-markovich/dotfiles/main/install.sh)"
```

This installs chezmoi, clones this repo, and applies every tracked config file to your `$HOME` in one step.

## What's managed here

- **Shell**: `.zshrc` — aliases, prompt, environment variables
- **Git**: global `.gitconfig` and `.gitignore_global`
- **VS Code**: `settings.json` and a full extensions list (`vscode-extensions.txt`), synced via chezmoi
- **Secrets safety**: every commit is scanned locally by a gitleaks pre-commit hook before it reaches GitHub

## Security model

Secrets (SSH keys, tokens) are never stored in plaintext. Sensitive files are encrypted with [age](https://github.com/FiloSottile/age) via `chezmoi add --encrypt` before being committed — see `.chezmoi.toml.tmpl` for the encryption config *(in progress, see Roadmap)*.

## Restore VS Code extensions on a new machine

```bash
xargs -n1 code --install-extension < vscode-extensions.txt
```

## Roadmap

- [ ] Encrypt SSH config with age
- [ ] Export and track apt/snap package manifest
- [ ] Verify full reproducibility in a clean Docker container

## Why this exists

Part of my transition from web development to DevOps in Germany — this repo demonstrates infrastructure-as-code principles applied to a personal workstation: idempotent setup, encrypted secrets, automated verification, and zero manual configuration drift between machines.
