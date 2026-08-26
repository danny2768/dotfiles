# Alacritty configuration
![image](https://github.com/danny2768/dotfiles/assets/82215769/4e9230a0-7052-4506-b83b-03c00233c3ae)
(The background belongs to the desktop, terminal is transparent)
## Themes
Please note that the themes part of the configuration depends on [Alacritty themes](https://github.com/alacritty/alacritty-theme)
Install them from their repo or clone this folder (alacritty) in the following path: `~/.config/`

## Font
The font configured is MesloLGS Nerd Font.
I suggest you to download it from [this link](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/S/Regular/MesloLGSNerdFont-Regular.ttf) or see the patched nerd-fonts to ensure compatibility.

- <https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts>

## Toggle opacity
`toggle-opacity` is a small script that flips (or sets) the `opacity` value in Alacritty's `alacritty.toml` `[window]` section.

Usage:
```
toggle-opacity            # flip between LOW and HIGH
toggle-opacity 0.5        # set an explicit opacity (0.0-1.0)
```

Env overrides: `ALACRITTY_TOGGLE_OPACITY_CONFIG`, `ALACRITTY_TOGGLE_OPACITY_LOW`, `ALACRITTY_TOGGLE_OPACITY_HIGH`.


