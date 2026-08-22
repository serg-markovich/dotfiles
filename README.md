# dotfiles

Personal configuration files (Zsh, Git) managed with [chezmoi](https://www.chezmoi.io/).
Secrets are kept out of version control entirely via a local `~/.secrets` file
(never tracked, see `.chezmoiignore`) and loaded into the shell at runtime.

## What's inside

- `dot_zshrc` — Zsh config, aliases, plugin setup (oh-my-zsh), OpenRouter routing for Claude Code
- `dot_gitconfig` — Git identity, aliases, sane defaults
- `dot_gitignore_global` — global ignore patterns, with a focus on never leaking secrets

## Quick start on a new machine

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
chezmoi init --apply serg-markovich
```

## Secrets

Never committed. Create `~/.secrets` locally on any machine and export
whatever API keys/tokens you need — it's sourced automatically from `dot_zshrc`
and ignored by chezmoi via `.chezmoiignore`.
