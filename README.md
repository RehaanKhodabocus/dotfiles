# dotfiles

![banner](banner.png)

My personal dotfiles for macOS, using:

- [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- [Ghostty](https://ghostty.org)
- [Zsh](https://zsh.org/) + [Starship](https://starship.rs)
- [tmux](https://github.com/tmux/tmux)
- [Neovim](https://neovim.io)

## Setting up a new Mac

### 1. Before formatting the old Mac

- Push any config changes (see [Saving config changes](#saving-config-changes)).
- Remove unwanted apps from the `Brewfile` and push.
- Export Raycast settings: Raycast → Settings → Advanced → Export.
- Back up your files and `~/.ssh`.

### 2. Run the setup script

On the new Mac, open Terminal and run:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/RehaanKhodabocus/dotfiles/main/setup.sh)"
```

It asks for your password **once**, then:

1. Installs Homebrew (and the Xcode Command Line Tools, which include git).
2. Clones this repo to `~/dotfiles`.
3. Symlinks the configs into place (see [What gets linked](#what-gets-linked)).
   Anything already there is renamed to `<name>.bak.<timestamp>`, not deleted.
4. Installs everything in the `Brewfile`.

The script is safe to re-run; finished steps are skipped. macFUSE and
Logitech G Hub may still show macOS "Allow" pop-ups. Approve those in
System Settings → Privacy & Security.

### 3. Finish up

Quit and reopen Terminal, then:

```sh
git config --global user.name  "Your Name"
git config --global user.email "you@example.com"
gh auth login    # GitHub.com → HTTPS → log in with browser
```

Things the `Brewfile` doesn't cover:

- VirtualBox (download from virtualbox.org)
- Claude Code and Codex
- `pip3 install --user pillow pypdf`
- `brew install go && go install golang.org/x/tools/gopls@latest`

Then open each app once:

- **Neovim:** plugins install on first launch.
- **tmux:** plugins install automatically.
- **AeroSpace:** allow it in System Settings → Privacy & Security → Accessibility.
- **Raycast:** import your settings export.

### 4. macOS settings

Run this last. It asks for your password once, applies Dock, Finder,
Desktop and menu bar settings, then reboots when you press Enter:

```sh
bash ~/dotfiles/macos.sh
```

## What gets linked

| Repo | Linked to |
|---|---|
| `.config/aerospace` | `~/.config/aerospace` |
| `.config/btop` | `~/.config/btop` |
| `.config/fastfetch` | `~/.config/fastfetch` |
| `.config/ghostty` | `~/.config/ghostty` |
| `.config/lazygit` | `~/.config/lazygit` |
| `.config/nvim` | `~/.config/nvim` |
| `.config/ripgrep` | `~/.config/ripgrep` |
| `.config/starship.toml` | `~/.config/starship.toml` |
| `.config/tmux` | `~/.config/tmux` |
| `.zshrc` | `~/.zshrc` |

The other files in `.config` (`bat`, `git`, `tldr`, `zsh`, `.curlrc`) are
not linked by `setup.sh`.

## Saving config changes

Because the configs are symlinked, editing `~/.config/<app>` edits the file
in this repo directly:

```sh
cd ~/dotfiles
git status    # what changed
git diff      # the exact changes
git add -A && git commit -m "what I changed" && git push
```

### Adding a new config

1. Move it into the repo: `mv ~/.config/<app> ~/dotfiles/.config/<app>`
2. Add `<app>` to the `CONFIGS` list at the top of `setup.sh`.
3. Re-run `bash ~/dotfiles/setup.sh` to create the link, then commit and push.

Never commit secrets. This repo is public. For example, `~/.config/gh`
holds your GitHub login token.

## Files

| File | Purpose |
|---|---|
| `setup.sh` | New Mac setup: Homebrew, clone, symlinks, Brewfile |
| `macos.sh` | macOS settings, then reboot |
| `Brewfile` | Homebrew apps and command-line tools |
| `hyprland.conf`, `linux.sh` | Linux setup (not used on macOS) |

## Credits

Based on [djamseed/dotfiles](https://github.com/djamseed/dotfiles). The Neovim
config started from [djamseed/nvim](https://github.com/djamseed/nvim).
