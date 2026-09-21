# Dotfiles

As you already know, in this repository you will find all my dofiles :).

## Bootstrapping a fresh machine

After the OS is installed and the apt/snap/flatpak package lists are restored:

```sh
git clone git@github.com:danny2768/dotfiles.git ~/git/General/dotfiles
cd ~/git/General/dotfiles
scripts/bootstrap.sh          # symlinks configs, installs p10k + tpm + the zsh-sudo plugin,
                               # restores autostart/mouse-scroll.sh.desktop
scripts/build-alacritty.sh    # builds Alacritty from source (not an apt/snap package here)
```

Then recreate `~/.zshrc.local` for machine-local secrets (never committed):

```sh
printf 'export NPM_PRIVATE_TOKEN=...\n' > ~/.zshrc.local && chmod 600 ~/.zshrc.local
```

To re-clone every other project repo in the same `~/git` layout: `scripts/clone-repos.sh`.

To recreate the `decobosa` OpenVPN connection: `scripts/setup-vpn.sh`. This repo holds no VPN secrets — the script reads a self-contained `decobosa.ovpn` (certs embedded) and a `certPassword.txt` from `~/Documents/RSI/2025/decobosa-r5/decobosa/` (restored separately, see the reinstall runbook), imports the connection via `nmcli`, and sets the cert passphrase non-interactively. Safe to re-run; it just refreshes the secret if the connection already exists. You'll still be prompted for your VPN username/password on connect — that's MFA, not something a script can supply.

## Repo layout

- **`zsh/`, `tmux/`, `alacritty/`, `vscode/`, `nvim/`** — the actual configs, described in their own sections below.
- **`scripts/`** — general-purpose tools that make sense to restore on any fresh machine: `bootstrap.sh` and `build-alacritty.sh` (setup), `clone-repos.sh` (recreates `~/git`), `setup-vpn.sh` (recreates the `decobosa` VPN connection), `git-reattach-submodules`, `yt-block`, `mouse-scroll.sh` (a real preference — scroll-button behavior via xinput, not a bug workaround). `bootstrap.sh` restores each one to wherever it actually needs to live: `git-reattach-submodules`/`yt-block`/`toggle-opacity` go to `~/.local/bin` (on `PATH`), but `mouse-scroll.sh` goes straight into `$HOME`, because `autostart/mouse-scroll.sh.desktop` hardcodes `Exec=/home/danny2768/mouse-scroll.sh` — anywhere else and autostart silently breaks. `setup-vpn.sh` isn't run by `bootstrap.sh` automatically since it depends on the separately-restored `Documents/RSI` backup — run it once that's in place.
- **`scripts/workarounds/`** — fixes for problems specific to *one past setup*, not this config or Kubuntu in general (a GPU/kernel-era icon-layout bug, a wake-from-sleep mouse bug, laptop fan control). **Not** installed or autostarted by `bootstrap.sh` — see [`scripts/workarounds/README.md`](./scripts/workarounds/README.md) and restore one by hand only if you actually hit that symptom again.
- **`autostart/`** — KDE autostart `.desktop` entries that are still genuinely wanted (currently just `mouse-scroll.sh.desktop`).

## General instructions

## Zsh
My .zshrc relies on in the following plugins. Please install them or remove them from config file.

- [PowerLevel10k](https://github.com/romkatv/powerlevel10k)
- [Zsh Syntax Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [Zsh Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [Zsh Sudo plugin](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/sudo/sudo.plugin.zsh)

- [batcat](https://github.com/sharkdp/bat)
- [lsd](https://github.com/lsd-rs/lsd)

Please note that .zshrc contains a series of aliases

```
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat='batcat'
alias python='python3'
```

## Alacritty
![image](https://github.com/danny2768/dotfiles/assets/82215769/4e9230a0-7052-4506-b83b-03c00233c3ae)
(The background belongs to the desktop, terminal is transparent)
### Themes
The themes of the configuration depends on [Alacritty themes.](https://github.com/alacritty/alacritty-theme)

Install them from their repo or clone this folder (alacritty) in the following path: `~/.config/`

### Font
The font configured is MesloLGS Nerd Font.
I suggest you to download it from [this link](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/S/Regular/MesloLGSNerdFont-Regular.ttf) or see the patched nerd-fonts to ensure compatibility.

- <https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts>

### Toggle opacity
`toggle-opacity` flips (or sets) the `opacity` value in Alacritty's `alacritty.toml` `[window]` section. See the [Alacritty README](./alacritty/README.md#toggle-opacity) for usage.


## Tmux
Save Tmux configuration file in: `~/.tmux.conf`

Note: this configuration file changes the Prefix to `Ctrl + a`

The configuration file uses the following tools:
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
- [Tmux Sensible](https://github.com/tmux-plugins/tmux-sensible)
- [Tmux Resurrect](https://github.com/tmux-plugins/tmux-resurrect)
- [Tmux Continuum](https://github.com/tmux-plugins/tmux-continuum)

## NeoVim
![image](https://github.com/danny2768/dotfiles/assets/82215769/2f1030a3-c072-435c-a3c2-cf90b02eb6a7)
![image](https://github.com/danny2768/dotfiles/assets/82215769/fa3e83e7-5d4f-4c93-bce5-58cb66771d5f)

My NeoVim configuration uses [LazyVim](https://www.lazyvim.org).

**Pre-requisites**:
- Install a recent NeoVim (check `nvim/lazyvim.json` for the version this was last tested against)
- Set Nerd Font as your terminal font (if you installed my Alacritty config you already did this step)

To see my configuration review this [README](./nvim/README.md)
