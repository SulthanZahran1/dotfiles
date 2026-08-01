# dotfiles

My personal CachyOS (Arch Linux) setup, managed with [chezmoi](https://www.chezmoi.io/). One repo, one bootstrap script, and a fresh machine ends up configured the same way every time.

Watch the walkthrough: *link to your video if you have one*

## What you get

Running `bootstrap.sh` builds:

- **258 native + 13 AUR packages** — everything from the kernel to your terminal emulator
- **11 npm global packages** — Claude Code, OpenCode, Infisical CLI, pnpm, and more
- **Hermes Agent** — with the Infisical secrets plugin and YOLO mode (no permission prompts)
- **15 systemd system services** — Docker, nginx, Tailscale, SSH, UFW, Bluetooth, and more
- **7 systemd user services** — Hermes gateway, IPU6 webcam daemon, no-mistakes daemon, and more
- **Docker containers** — Guacamole (remote desktop), Bella local dev stack
- **86+ dotfiles** — shell config, KDE Plasma, terminals, editors, SSH, git, systemd, GTK, fonts
- **Secrets isolated in Infisical** — no plaintext credentials on disk

## Prerequisites

- **CachyOS** (or any Arch-based distro) — the bootstrap script uses `pacman` and `yay`
- **GitHub account** — for `chezmoi init` to clone the repo
- **Infisical account** — for secret management (free tier at [app.infisical.com](https://app.infisical.com))

## Fresh-machine setup

On a brand new CachyOS install:

```bash
# 1. Install chezmoi and apply dotfiles
sudo pacman -S chezmoi
chezmoi init https://github.com/SulthanZahran1/dotfiles
chezmoi apply

# 2. Run the bootstrap script
~/.local/share/chezmoi/scripts/bootstrap.sh
```

After the bootstrap finishes:

```bash
# 3. Connect Infisical
infisical login
infisical init
infisical secrets set HERMES_CUSTOM_API_AIAND_COM_API_KEY="..." --env=dev
infisical secrets set SUDO_PASSWORD="..." --env=dev
infisical secrets set EXA_API_KEY="..." --env=dev
```

That's it. Your machine is now a replica.

## Daily use

### Adding a new package

```bash
# Install it normally
sudo pacman -S some-package

# Update the package list
pacman -Qqe > ~/.local/share/chezmoi/scripts/pkglist.txt
pacman -Qqm > ~/.local/share/chezmoi/scripts/aurlist.txt

# Commit and push
cd ~/.local/share/chezmoi
git add -A && git commit -m "add some-package" && git push
```

### Editing a dotfile

```bash
# Edit the file in place
vim ~/.config/something.conf

# Tell chezmoi about the change
chezmoi re-add ~/.config/something.conf

# Commit and push
cd ~/.local/share/chezmoi
git add -A && git commit -m "update something.conf" && git push
```

### Quick sync (alias)

```bash
alias chezmoi-sync='cd ~/.local/share/chezmoi && \
  pacman -Qqe > scripts/pkglist.txt && \
  pacman -Qqm > scripts/aurlist.txt && \
  git add -A && git commit -m "sync $(date +%Y-%m-%d)" && git push'
```

## Make it yours

This repo is mine. If you fork it, review these before you run `bootstrap.sh`:

- **`scripts/pkglist.txt` and `scripts/aurlist.txt`** — these are my exact package lists. You'll have packages you don't want and miss packages you do. Regenerate them with `pacman -Qqe > pkglist.txt` and `pacman -Qqm > aurlist.txt` after installing your own set.
- **`private_dot_hermes/private_config.yaml`** — contains my Hermes config including the Infisical plugin settings. You'll need to configure your own `secrets.infisical.env` and any provider API keys.
- **`dot_gitconfig`** — my git identity. Change the name and email.
- **`dot_config/gh/private_config.yml`** — GitHub CLI config. You'll need to run `gh auth login`.
- **`dot_config/ssh/config`** — SSH config with my hosts. Yours will differ.
- **`dot_config/systemd/user/*.service`** — systemd user services for Hermes gateway, webcam daemon, etc. You may not need all of them.
- **`scripts/bootstrap.sh`** — the bootstrap script enables specific systemd services and starts specific Docker containers. Review the `SYSTEM_SERVICES` and `USER_SERVICES` arrays, and the Docker compose paths.

## Architecture

```
~/.local/share/chezmoi/
├── dot_bashrc                          # ~/.bashrc
├── dot_gitconfig                       # ~/.gitconfig
├── dot_zshrc                           # ~/.zshrc
├── dot_config/                         # ~/.config/
│   ├── kdeglobals, kwinrc, ...         # KDE Plasma settings
│   ├── alacritty/, wezterm/, kitty/    # Terminal configs
│   ├── nvim/                           # Neovim config
│   ├── tmux/                           # Tmux config
│   ├── systemd/user/                   # User systemd services
│   ├── ssh/                            # SSH config
│   ├── git/                            # Git config
│   ├── gh/                             # GitHub CLI config
│   ├── gtk-3.0/, gtk-4.0/             # GTK theme
│   └── pipewire/, wireplumber/         # Audio config
├── private_dot_hermes/                 # ~/.hermes/
│   └── private_config.yaml             # Hermes config (Infisical plugin, YOLO mode)
└── scripts/
    ├── bootstrap.sh                    # Full machine reprovisioning
    ├── pkglist.txt                     # Native packages (pacman -Qqe)
    └── aurlist.txt                     # AUR packages (pacman -Qqm)
```

## Three pillars

This setup follows the same philosophy as [kunchenguid/dotfiles](https://github.com/kunchenguid/dotfiles):

1. **Mindset shift** — the machine is treated as disposable. If an agent breaks it, wipe and rebuild.
2. **Fully reproducible** — one command (`bootstrap.sh`) rebuilds the entire machine from scratch.
3. **Isolated secrets** — credentials live in Infisical, not in plaintext on disk. The Hermes Infisical plugin resolves them at startup.

## License

MIT
