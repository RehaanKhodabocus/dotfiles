#!/bin/bash
#
# setup.sh - Set up a new Mac from this dotfiles repo.
#
# Asks for your password once, then installs Homebrew, clones this repo,
# links configs into ~/.config and installs everything in the Brewfile.
#
# On a fresh Mac:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/RehaanKhodabocus/dotfiles/main/setup.sh)"
#
# From an existing clone:
#   bash ~/dotfiles/setup.sh
#
# Safe to re-run: finished steps are skipped.

set -euo pipefail

REPO_URL="https://github.com/RehaanKhodabocus/dotfiles.git"
DOTFILES="$HOME/dotfiles"

# Entries in dotfiles/.config that get linked into ~/.config
CONFIGS=(aerospace btop fastfetch ghostty tmux nvim starship.toml)

info() { printf '\n\033[1;34m==>\033[0m \033[1m%s\033[0m\n' "$*"; }
warn() { printf '\033[1;33mWarning:\033[0m %s\n' "$*" >&2; }
die() { printf '\033[1;31mError:\033[0m %s\n' "$*" >&2; exit 1; }

[[ "$(uname)" == "Darwin" ]] || die "This script is for macOS."
[[ "$EUID" -ne 0 ]] || die "Run this as your normal user, not with sudo."

# -- password ------------------------------------------------------------------
# A "keep sudo alive" loop doesn't work here: `brew` resets the sudo timestamp
# every time it runs, so each cask that needs sudo would ask again. Instead,
# give sudo an askpass helper that answers with the password entered once.
# Homebrew's installer and `brew` both use it via $SUDO_ASKPASS. The password
# lives in a private temp folder that is deleted when the script exits.

info "Password"
SETUP_TMP="$(mktemp -d)"
trap 'rm -rf "$SETUP_TMP"' EXIT
chmod 700 "$SETUP_TMP"

read -r -s -p "Enter your Mac password (asked only once): " password < /dev/tty
echo
(umask 077 && printf '%s\n' "$password" > "$SETUP_TMP/password")
unset password

cat > "$SETUP_TMP/askpass" <<EOF
#!/bin/sh
cat "$SETUP_TMP/password"
EOF
chmod 700 "$SETUP_TMP/askpass"
export SUDO_ASKPASS="$SETUP_TMP/askpass"

sudo -k -A true 2>/dev/null || die "Incorrect password."
echo "Password OK."

# -- homebrew ------------------------------------------------------------------

info "Homebrew"
if [[ "$(uname -m)" == "arm64" ]]; then
    BREW=/opt/homebrew/bin/brew
else
    BREW=/usr/local/bin/brew
fi

if [[ -x "$BREW" ]]; then
    echo "Already installed."
else
    # Also installs the Xcode Command Line Tools (git) if missing.
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$("$BREW" shellenv)"
# shellcheck disable=SC2016 # written literally so it runs in every new shell
BREW_ENV_LINE='eval "$('"$BREW"' shellenv)"'
if ! grep -qsF "$BREW_ENV_LINE" "$HOME/.zprofile"; then
    printf '\n%s\n' "$BREW_ENV_LINE" >> "$HOME/.zprofile"
    echo "Added Homebrew to ~/.zprofile."
fi

# -- dotfiles ------------------------------------------------------------------

info "Dotfiles"
if [[ -d "$DOTFILES/.git" ]]; then
    echo "Already cloned at $DOTFILES."
else
    git clone "$REPO_URL" "$DOTFILES"
fi

# -- links ---------------------------------------------------------------------
# Anything already in the way is moved to <name>.bak.<timestamp>, not deleted.

link() {
    local src="$1" dest="$2" backup
    if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
        echo "ok      $dest"
        return
    fi
    if [[ -e "$dest" || -L "$dest" ]]; then
        backup="$dest.bak.$(date +%Y%m%d%H%M%S)"
        mv "$dest" "$backup"
        echo "backup  $dest -> $backup"
    fi
    ln -s "$src" "$dest"
    echo "linked  $dest -> $src"
}

info "Linking configs"
mkdir -p "$HOME/.config"
for name in "${CONFIGS[@]}"; do
    if [[ -e "$DOTFILES/.config/$name" ]]; then
        link "$DOTFILES/.config/$name" "$HOME/.config/$name"
    else
        warn "$DOTFILES/.config/$name not found, skipping."
    fi
done
link "$DOTFILES/.zshrc" "$HOME/.zshrc"

# -- brewfile ------------------------------------------------------------------

info "Installing Brewfile packages (this takes a while)"
# Third-party taps must be trusted before `brew bundle` can load them.
if grep -q "gromgit/fuse" "$DOTFILES/Brewfile"; then
    brew tap gromgit/fuse && brew trust gromgit/fuse || warn "Could not trust gromgit/fuse; NTFS support may be skipped."
fi

if ! brew bundle --file "$DOTFILES/Brewfile"; then
    warn "Some packages failed. Re-run: brew bundle --file $DOTFILES/Brewfile"
fi

# -- done ----------------------------------------------------------------------

info "Done! Remaining manual steps:"
cat <<'EOF'
  1. Quit and reopen your terminal.
  2. git config --global user.name  "RehaanKhodabocus"
     git config --global user.email "you@example.com"
  3. gh auth login            (GitHub.com -> HTTPS -> browser)
  4. Install manually: VirtualBox, Claude Code, Codex
     pip3 install --user pillow pypdf
     brew install go && go install golang.org/x/tools/gopls@latest
  5. Open nvim once so plugins install.
  6. Allow AeroSpace in System Settings -> Privacy & Security -> Accessibility.
     Approve macFUSE / Logitech G Hub system prompts if asked.
  7. Import your Raycast settings export.
  8. bash ~/dotfiles/macos.sh  (Mac settings; reboots at the end)
EOF
