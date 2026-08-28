# dotfiles

Reproducible workstation configuration for Zsh, Git, and VS Code, managed with [chezmoi](https://www.chezmoi.io) and secured with [gitleaks](https://github.com/gitleaks/gitleaks) pre-commit scanning.

## Quick start (new machine)

```bash
sh -c "$(curl -fsLS https://raw.githubusercontent.com/serg-markovich/dotfiles/main/install.sh)"
```

This installs chezmoi, clones this repo, and applies every tracked config file to `$HOME` in one step.

## What's managed here

- **Shell**: `.zshrc` — aliases, prompt, environment variables
- **Git**: global `.gitconfig` and `.gitignore_global`
- **VS Code**: `settings.json` and a full extensions list (`vscode-extensions.txt`)
- **Secrets safety**: every commit is scanned locally by a gitleaks pre-commit hook

## Security model

Sensitive files (SSH keys, tokens) are encrypted with [age](https://github.com/FiloSottile/age) via `chezmoi add --encrypt` before being committed — plaintext secrets never touch this repository.

## Restore VS Code extensions on a new machine

```bash
xargs -n1 code --install-extension < vscode-extensions.txt
```

## Roadmap

- [ ] Encrypt SSH config with age
- [ ] Export and track apt/snap package manifest
- [ ] Verify full reproducibility in a clean Docker container
## Setting up SSH on a new machine

Bootstrap uses `--keep-going`, so a missing `age` decryption key won't
block the rest of your dotfiles — but the SSH private key itself won't
decrypt until you provide it:

1. Copy your `age` identity to `~/.config/chezmoi/key.txt`
   (secure channel only — password manager, USB, never git/email).
2. Re-run `chezmoi apply` to pick up the SSH key.

## Known limitations

- `PATH` entries under `$HOME` must never hardcode a username
  (see commit c234acb) — dotfiles must work under any account.
