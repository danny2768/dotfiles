# Workarounds

Everything here fixed a problem on a *specific* past setup, not something
inherent to this dotfiles config or to Kubuntu in general. `scripts/bootstrap.sh`
does **not** install or autostart any of these — restore one by hand only if
you actually hit the symptom it describes.

## `fix-mouse.sh`

Worked around the mouse not responding after waking DC-Desktop from sleep,
on the old GPU/kernel combo (pre-26.04, pre RX 9060 XT driver stack).
Disables and re-enables the mouse's xinput device IDs (`9` and `15` — these
are machine- and session-specific and may not match after a fresh install;
run `xinput list` to find the real ones first if you ever need this again).

If wake-from-sleep works fine after the reinstall, ignore this file.

## `restore-icons.sh` + `icon-layout-backup`

Worked around the Plasma desktop icon layout resetting itself, also tied to
the old GPU/kernel combo — `plasmashell` would occasionally forget icon
positions and this restored them from a saved snapshot
(`icon-layout-backup`, captured 2026-07-06) and restarted `plasmashell`.

If icons stay put after the reinstall, ignore both files. If the snapshot
ever needs refreshing: `cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc scripts/workarounds/icon-layout-backup`.

## `fan_ramp.sh`

**Laptop-only** — controls fan curve on a different machine entirely, not
DC-Desktop. Kept here only so it travels with the rest of the dotfiles when
setting up the laptop; irrelevant to this machine's reinstall.
