#!/bin/bash
# bootstrap.sh — Full machine reprovisioning from scratch
# Run after: chezmoi init https://github.com/SulthanZahran1/dotfiles --apply
#
# This script installs everything needed to replicate this machine.
# Designed to be idempotent — safe to re-run.

set -euo pipefail

echo "=== CachyOS Full Bootstrap ==="
echo "Starting at $(date)"
echo ""

# ---------------------------------------------------------------------------
# 1. Native packages
# ---------------------------------------------------------------------------
PKG_LIST="$HOME/.local/share/chezmoi/scripts/pkglist.txt"
if [ -f "$PKG_LIST" ]; then
  echo "[1/9] Installing native packages ($(wc -l < "$PKG_LIST") packages)..."
  sudo pacman -S --needed --noconfirm - < "$PKG_LIST"
else
  echo "[1/9] No pkglist.txt found — skipping"
fi

# ---------------------------------------------------------------------------
# 2. AUR packages (via yay)
# ---------------------------------------------------------------------------
AUR_LIST="$HOME/.local/share/chezmoi/scripts/aurlist.txt"
if [ -f "$AUR_LIST" ]; then
  echo "[2/9] Installing AUR packages ($(wc -l < "$AUR_LIST") packages)..."
  if ! command -v yay &>/dev/null; then
    echo "  Installing yay..."
    sudo pacman -S --needed --noconfirm base-devel
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    (cd "$tmpdir/yay" && makepkg -si --noconfirm)
    rm -rf "$tmpdir"
  fi
  yay -S --needed --noconfirm - < "$AUR_LIST"
else
  echo "[2/9] No aurlist.txt found — skipping"
fi

# ---------------------------------------------------------------------------
# 3. npm global packages
# ---------------------------------------------------------------------------
echo "[3/9] Installing npm global packages..."
NPM_PKGS=(
  "@anthropic-ai/claude-code"
  "@humanlayer/cli"
  "@infisical/cli"
  "@inulute/cux"
  "@karpeleslab/teamclaude"
  "dotenv-cli"
  "gnhf"
  "humanlayer"
  "lavish-axi"
  "opencode-ai"
  "pnpm"
)
for pkg in "${NPM_PKGS[@]}"; do
  if ! npm list -g --depth=0 2>/dev/null | grep -q "$pkg"; then
    echo "  Installing $pkg..."
    npm install -g "$pkg" 2>/dev/null
  else
    echo "  $pkg already installed"
  fi
done

# ---------------------------------------------------------------------------
# 4. Hermes Agent
# ---------------------------------------------------------------------------
echo "[4/9] Installing Hermes Agent..."
if ! command -v hermes &>/dev/null; then
  curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
else
  echo "  Hermes already installed"
fi

# ---------------------------------------------------------------------------
# 5. Infisical CLI + plugin
# ---------------------------------------------------------------------------
echo "[5/9] Installing Infisical plugin..."
if ! command -v infisical &>/dev/null; then
  echo "  ERROR: infisical CLI should have been installed in step 3"
  echo "  Run: npm install -g @infisical/cli"
fi
if ! hermes plugins list 2>/dev/null | grep -q infisical; then
  echo "  Installing hermes-infisical-secrets plugin..."
  hermes plugins install SulthanZahran1/hermes-infisical-secrets
  hermes plugins enable infisical
else
  echo "  Infisical plugin already installed"
fi

# ---------------------------------------------------------------------------
# 6. Enable systemd services (system)
# ---------------------------------------------------------------------------
echo "[6/9] Enabling systemd system services..."
SYSTEM_SERVICES=(
  "ananicy-cpp"
  "avahi-daemon"
  "bluetooth"
  "docker"
  "intel_lpmd"
  "limine-snapper-sync"
  "netbird"
  "NetworkManager"
  "nginx"
  "sshd"
  "systemd-resolved"
  "systemd-timesyncd"
  "tailscaled"
  "tomcat9"
  "ufw"
)
for svc in "${SYSTEM_SERVICES[@]}"; do
  sudo systemctl enable --now "$svc" 2>/dev/null || echo "  (could not enable $svc)"
done

# ---------------------------------------------------------------------------
# 7. Enable systemd services (user)
# ---------------------------------------------------------------------------
echo "[7/9] Enabling systemd user services..."
USER_SERVICES=(
  "hermes-gateway"
  "ipu6-webcam-daemon"
  "no-mistakes-daemon-539489af"
  "wireplumber"
  "xdg-user-dirs"
)
for svc in "${USER_SERVICES[@]}"; do
  systemctl --user enable --now "$svc" 2>/dev/null || echo "  (could not enable $svc)"
done

# ---------------------------------------------------------------------------
# 8. Docker containers (via docker-compose)
# ---------------------------------------------------------------------------
echo "[8/9] Setting up Docker containers..."
# Guacamole (remote desktop)
if [ -d "$HOME/code/guacamole" ]; then
  echo "  Starting Guacamole..."
  cd "$HOME/code/guacamole" && docker compose up -d 2>/dev/null || echo "  (guacamole compose not found)"
fi

# Bella local dev stack
if [ -f "$HOME/code/bella-enterprise/docker-compose.local.yml" ]; then
  echo "  Starting Bella local stack..."
  cd "$HOME/code/bella-enterprise" && docker compose -f docker-compose.local.yml up -d 2>/dev/null || echo "  (bella compose not found)"
fi

# ---------------------------------------------------------------------------
# 9. Final touches
# ---------------------------------------------------------------------------
echo "[9/9] Final touches..."
# Ensure Hermes config has YOLO mode
hermes config set approvals.mode off 2>/dev/null || true
hermes config set security.redact_secrets false 2>/dev/null || true

echo ""
echo "=== Bootstrap complete ==="
echo ""
echo "Manual steps required:"
echo "  1. infisical login           # Browser auth to Infisical Cloud"
echo "  2. infisical init            # Link project (creates .infisical.json)"
echo "  3. infisical secrets set ... # Add your secrets to dev env"
echo ""
echo "Done at $(date)"
