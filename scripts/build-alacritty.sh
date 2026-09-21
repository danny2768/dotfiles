#!/usr/bin/env bash
# Builds and installs Alacritty from source, matching how it's set up on
# this machine (a manual build in ~/alacritty -> /usr/local/bin, not an
# apt/snap package). Re-check https://github.com/alacritty/alacritty/blob/master/INSTALL.md
# in case build deps changed since this was written.
set -euo pipefail

# cargo/rustc via apt (not rustup — this machine's toolchain is apt's cargo
# 1.75.0, which is what actually built the alacritty binary in use; a lone
# `cargo` in the apt-manual package list pulls rustc in as a dependency, but
# this line makes the script runnable standalone too, before the full
# package restore).
DEPS=(cargo rustc cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev g++ python3 scdoc)
echo "Installing build dependencies (sudo)..."
sudo apt-get update
sudo apt-get install -y "${DEPS[@]}"

SRC="$HOME/alacritty"
if [ ! -d "$SRC" ]; then
  git clone https://github.com/alacritty/alacritty.git "$SRC"
fi
cd "$SRC"

echo "Building release binary (a few minutes)..."
cargo build --release

echo "Installing binary, terminfo, desktop entry..."
sudo cp target/release/alacritty /usr/local/bin/alacritty
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database 2>/dev/null || true

echo "Installed: $(alacritty --version)"
