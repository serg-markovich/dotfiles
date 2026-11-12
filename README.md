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

## Setting up SSH on a new machine

Bootstrap uses `--keep-going`, so a missing `age` decryption key won't
block the rest of your dotfiles — but the SSH private key itself won't
decrypt until you provide it:

1. Copy your `age` identity to `~/.config/chezmoi/key.txt`
   (secure channel only — password manager, USB, never git/email).
2. Re-run `chezmoi apply` to pick up the SSH key.

## Restore VS Code extensions on a new machine

```bash
xargs -n1 code --install-extension < vscode-extensions.txt
```

## Troubleshooting

### `chezmoi apply` fails on `.ssh/id_ed25519`

Expected behavior, not a bug. The SSH private key is age-encrypted, and
decryption needs `~/.config/chezmoi/key.txt`. Without that file, chezmoi
reports a decryption error for `.ssh/id_ed25519`.

Fix: follow [Setting up SSH on a new machine](#setting-up-ssh-on-a-new-machine),
then re-run `chezmoi apply`.

### One undecryptable file blocked all other dotfiles

Previously, a single file that could not be decrypted aborted the whole
bootstrap, so every file after it was skipped. This was fixed in
[`f5692e1`](https://github.com/serg-markovich/dotfiles/commit/f5692e1): `install.sh` now runs
`chezmoi init --apply --keep-going`.

Do not remove `--keep-going` as "redundant". Without it, a missing age key
leaves the machine with only a partial set of dotfiles.

## Conventions

Rules for anyone editing `dot_*` files, including future me:

- **No hardcoded paths under `$HOME`.** Never write a username into a path
  (for example `/home/<user>/...`); use `$HOME` instead. Dotfiles must work
  under any account. A hardcoded `PATH` entry broke portability and was fixed in
  [`c234acb`](https://github.com/serg-markovich/dotfiles/commit/c234acb).
- **Keep `--keep-going` in `install.sh`.** See Troubleshooting above.
- **Never commit plaintext secrets.** Add them with `chezmoi add --encrypt`.

## Secrets rotation

The procedure for the `age` key (where the backup lives, how to rotate it,
what to do if it is compromised) is tracked in
[#10](https://github.com/serg-markovich/dotfiles/issues/10) and is not yet documented.

## Roadmap

- [ ] Encrypt SSH config with age
- [ ] Export and track apt/snap package manifest
- [ ] Verify full reproducibility in a clean Docker container
