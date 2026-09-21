#!/usr/bin/env bash
# Sets up the shell/terminal/editor stack on a fresh machine and symlinks
# this repo's configs into place. Idempotent — safe to re-run.
#
# Assumes the apt package list has already been restored (zsh,
# zsh-autosuggestions, zsh-syntax-highlighting, bat, lsd, git, curl, cargo,
# build headers, etc.) — see the reinstall runbook. This script only
# handles what apt doesn't: the hand-placed zsh-sudo plugin, Powerlevel10k,
# tmux's plugin manager, and wiring this repo's files into $HOME.
#
# Note: .zshrc does NOT use the oh-my-zsh framework (no `source
# $ZSH/oh-my-zsh.sh`, no plugins=() array) even though ~/.oh-my-zsh exists
# on the source machine — it's vestigial there. This script does not
# install oh-my-zsh on purpose.
#
# Usage: scripts/bootstrap.sh

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "dotfiles repo: $DOTFILES"

link() {
  # $1 = source path in repo, $2 = target path under $HOME
  mkdir -p "$(dirname "$2")"
  if [ -e "$2" ] && [ ! -L "$2" ]; then
    mv "$2" "$2.bak.$(date +%s)"
    echo "  backed up existing $(basename "$2")"
  fi
  ln -sfn "$1" "$2"
  echo "  linked $2 -> $1"
}

echo "== zsh-sudo plugin (not an apt package — .zshrc expects it at /usr/share/zsh-sudo/) =="
if [ ! -f /usr/share/zsh-sudo/sudo.plugin.zsh ]; then
  sudo mkdir -p /usr/share/zsh-sudo
  sudo cp "$DOTFILES/zsh/sudo.plugin.zsh" /usr/share/zsh-sudo/sudo.plugin.zsh
  echo "  installed"
else
  echo "  already present"
fi

echo "== Powerlevel10k =="
if [ ! -d "$HOME/powerlevel10k" ]; then
  git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k"
else
  echo "  already cloned"
fi

echo "== tmux plugin manager (tpm) =="
mkdir -p "$HOME/.tmux/plugins"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone --quiet https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "  already cloned"
fi

echo "== symlinking dotfiles =="
link "$DOTFILES/zsh/.zshrc"                "$HOME/.zshrc"
link "$DOTFILES/zsh/.p10k.zsh"              "$HOME/.p10k.zsh"
link "$DOTFILES/tmux/tmux.conf"             "$HOME/.tmux.conf"
mkdir -p "$HOME/.config/alacritty"
link "$DOTFILES/alacritty/alacritty.toml"   "$HOME/.config/alacritty/alacritty.toml"
[ -d "$DOTFILES/alacritty/themes" ] && link "$DOTFILES/alacritty/themes" "$HOME/.config/alacritty/themes"
mkdir -p "$HOME/.config/Code/User"
link "$DOTFILES/vscode/keybindings.json"    "$HOME/.config/Code/User/keybindings.json"
mkdir -p "$HOME/.config/nvim"
for f in init.lua lazyvim.json lazy-lock.json stylua.toml; do
  [ -f "$DOTFILES/nvim/$f" ] && link "$DOTFILES/nvim/$f" "$HOME/.config/nvim/$f"
done
[ -d "$DOTFILES/nvim/lua" ]      && link "$DOTFILES/nvim/lua" "$HOME/.config/nvim/lua"
[ -d "$DOTFILES/nvim/snippets" ] && link "$DOTFILES/nvim/snippets" "$HOME/.config/nvim/snippets"

echo "== linking scripts/ into ~/.local/bin =="
# git-reattach-submodules, yt-block and toggle-opacity lived in ~/.local/bin
# on the source machine, so PATH picks them up as plain commands.
mkdir -p "$HOME/.local/bin"
link "$DOTFILES/scripts/git-reattach-submodules" "$HOME/.local/bin/git-reattach-submodules"
link "$DOTFILES/scripts/yt-block"                "$HOME/.local/bin/yt-block"
link "$DOTFILES/alacritty/toggle-opacity"        "$HOME/.local/bin/toggle-opacity"

echo "== linking home-root scripts =="
# mouse-scroll.sh lives directly in $HOME, NOT ~/.local/bin — the autostart
# entry below hardcodes the absolute path (Exec=/home/danny2768/mouse-scroll.sh),
# so it has to land in the same spot or autostart silently breaks.
link "$DOTFILES/scripts/mouse-scroll.sh" "$HOME/mouse-scroll.sh"

echo "== restoring KDE autostart entries =="
mkdir -p "$HOME/.config/autostart"
for f in "$DOTFILES"/autostart/*.desktop; do
  [ -f "$f" ] || continue
  cp "$f" "$HOME/.config/autostart/$(basename "$f")"
  echo "  restored $(basename "$f")"
done

echo "== default shell =="
if [ "${SHELL:-}" != "$(command -v zsh)" ]; then
  chsh -s "$(command -v zsh)" && echo "  set zsh as default shell (takes effect next login)"
else
  echo "  already zsh"
fi

cat <<'EOF'

== next steps ==
1. Recreate ~/.zshrc.local for machine-local secrets (never tracked in git):
     printf 'export NPM_PRIVATE_TOKEN=...\n' > ~/.zshrc.local && chmod 600 ~/.zshrc.local
2. Build Alacritty from source — it was hand-built here, not apt/snap-installed:
     scripts/build-alacritty.sh
3. Start tmux once, press <prefix> + I, to have tpm fetch tmux-sensible,
   tmux-resurrect and tmux-continuum.
4. Open a new terminal (or `exec zsh`) to pick up the new config.

== NOT restored automatically — scripts/workarounds/ ==
These fixed problems specific to a past install, not this machine/OS in
general. Only run one if you actually hit the symptom again — see
scripts/workarounds/README.md for what each one was for and why it's opt-in.
EOF
