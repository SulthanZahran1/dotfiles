# Project notes for agents

Deliberate decisions in this repo — do NOT silently revert them:

- **`approvals.mode: off` and `security.redact_secrets: false` in Hermes config** is intentional. The safety net is reproducibility (wipe and rebuild) + isolated secrets (Infisical), not permission prompts. Do not re-enable approvals.
- **Secrets live in Infisical, not in `.env`.** The `~/.hermes/.env` file is sanitized (no credentials). The Infisical plugin resolves them at startup. Do not add secrets back to `.env`.
- **`bootstrap.sh` is the single source of truth for machine setup.** If something needs to be installed or configured on a fresh machine, it belongs in `bootstrap.sh` or in a chezmoi-managed dotfile. Do not add ad-hoc setup instructions to the README.
- **Package lists (`pkglist.txt`, `aurlist.txt`) are snapshots, not manifests.** They are regenerated with `pacman -Qqe > pkglist.txt`. If a package is missing, install it with pacman and regenerate the list — do not edit the text file by hand.
- **This is a chezmoi repo, not a bare git repo.** Dotfiles are managed with `chezmoi add` and `chezmoi re-add`. Do not symlink or copy files manually — use chezmoi commands.

## Maintaining this file

Keep this file for knowledge useful to almost every future agent session in this project.
Do not repeat what the codebase already shows; point to the authoritative file or command instead.
Prefer rewriting or pruning existing entries over appending new ones.
When updating this file, preserve this bar for all agents and keep entries concise.
