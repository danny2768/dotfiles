# Dotfiles

As you already know, in this repository you will find all my dofiles :).

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

My NeoVim configuration uses [NvChad](https://nvchad.com)

**Pre-requisites for NvChad**:
- Install NeoVim 0.9.4
- Set Nerd Font as your terminal font (If you install my alacritty config you already did this step.)

To see my configuration of NvChad review this [README](./nvim/README.md)
