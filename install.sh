#!/bin/sh
set -e

echo "==> Installing chezmoi and applying dotfiles for serg-markovich..."
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --keep-going serg-markovich

echo "==> Done. Open a new terminal to load zsh config."
