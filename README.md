# Dotfiles

As you already know, in this repository you will find all my dofiles.

## General instructions

### Zsh
My .zshrc relies on in the following plugins. Please install them or remove them from config file.

[PowerLevel10k](https://github.com/romkatv/powerlevel10k)
[Zsh Syntax Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
[Zsh Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
[Zsh Sudo plugin](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/sudo/sudo.plugin.zsh)

[batcat](https://github.com/sharkdp/bat)
[lsd](https://github.com/lsd-rs/lsd)

Please note that .zshrc contains a series of aliases

alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat='batcat'
alias python='python3'

### Alacritty
Copy alacritty folder in the following path: `~/.config/` and review this [README](./alacritty/README.md).


### Tmux
Save Tmux configuration file in: `~/.tmux.conf`

Note: this configuration file changes the Prefix to `Ctrl + a`

The configuration file uses the following tools:
[Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
[Tmux Sensible](https://github.com/tmux-plugins/tmux-sensible)
[Tmux Resurrect](https://github.com/tmux-plugins/tmux-resurrect)


### NeoVim
My NeoVim configuration uses [NvChad](https://nvchad.com)

**Pre-requisites for NvChad**:
- Install NeoVim 0.9.4
- Set Nerd Font as your terminal font (If you install my alacritty config you already did this step.)

To see my configuration of NvChad review this [README](./nvim/README.md)
