# Sway Window Manager Configuration

A comprehensive, modern, and feature-rich Sway configuration with Catppuccin Mocha theming, Vim-style navigation, and extensive customization.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Dependencies](#dependencies)
- [Color Scheme](#color-scheme)
- [Key Bindings](#key-bindings)
  - [Core Applications](#core-applications)
  - [Window Management](#window-management)
  - [Focus Navigation](#focus-navigation)
  - [Window Movement](#window-movement)
  - [Workspaces](#workspaces)
  - [Scratchpad](#scratchpad)
  - [Screenshots](#screenshots)
  - [Media & Hardware Keys](#media--hardware-keys)
  - [Quick Actions](#quick-actions)
  - [Session Management](#session-management)
- [Modes](#modes)
  - [Resize Mode](#resize-mode)
  - [Power Menu Mode](#power-menu-mode)
  - [Apps Mode](#apps-mode)
  - [Tools Mode](#tools-mode)
- [Input Configuration](#input-configuration)
- [Output Configuration](#output-configuration)
- [Window Rules](#window-rules)
- [Autostart Applications](#autostart-applications)
- [Idle & Lock Configuration](#idle--lock-configuration)
- [Custom Scripts](#custom-scripts)
- [Customization](#customization)

---

## Overview

This Sway configuration provides a polished, efficient tiling window manager experience. It features:

- **Catppuccin Mocha** color scheme for a beautiful, eye-friendly aesthetic
- **Vim-style keybindings** (`h`, `j`, `k`, `l`) for navigation
- **Named workspaces** with Nerd Font icons
- **Multiple modes** for resize, power management, app launching, and tools
- **Comprehensive hardware key support** for volume, brightness, and media controls
- **Smart gaps and borders** that adapt to your workflow
- **Dual keyboard layout** support (US English & Arabic)

---

## Features

| Feature | Description |
|---------|-------------|
| 🎨 Catppuccin Mocha | Beautiful pastel color scheme |
| ⌨️ Vim Navigation | `hjkl` movement keys |
| 🖥️ Named Workspaces | 10 workspaces with descriptive icons |
| 🔒 Auto-lock | Automatic screen lock and power management |
| 📸 Screenshots | Multiple screenshot modes (full, selection, clipboard) |
| 🎵 Media Control | Full media key support via playerctl |
| 📋 Clipboard History | Persistent clipboard with cliphist |
| 🎯 Auto-tiling | Automatic window arrangement |
| 🌐 Multi-language | US/Arabic keyboard toggle |

---

## Dependencies

### Required

| Package | Purpose |
|---------|---------|
| `sway` | Wayland compositor |
| `waybar` | Status bar |
| `rofi` | Application launcher |
| `ghostty` | Terminal emulator |
| `swaylock` | Screen locker |
| `swayidle` | Idle management |
| `grim` | Screenshot utility |
| `slurp` | Region selection |
| `wl-clipboard` | Clipboard utilities |
| `cliphist` | Clipboard history |
| `mako` | Notification daemon |

### Recommended

| Package | Purpose |
|---------|---------|
| `brave` | Web browser |
| `thunar` | File manager |
| `autotiling` | Automatic tiling script |
| `playerctl` | Media player control |
| `pactl` (PulseAudio/PipeWire) | Volume control |
| `brightnessctl` | Brightness control |
| `nm-applet` | Network manager applet |
| `blueman` | Bluetooth manager |
| `polkit-gnome` | Authentication agent |
| `imagemagick` | Color picker functionality |

### Fonts

- **JetBrainsMono Nerd Font** - Primary UI font with icon support

---

## Color Scheme

This configuration uses the **Catppuccin Mocha** color palette:

| Color | Hex | Usage |
|-------|-----|-------|
| Rosewater | `#f5e0dc` | Accents |
| Flamingo | `#f2cdcd` | Accents |
| Pink | `#f5c2e7` | Accents |
| Mauve | `#cba6f7` | **Focused windows** |
| Red | `#f38ba8` | Urgent windows |
| Maroon | `#eba0ac` | Accents |
| Peach | `#fab387` | Accents |
| Yellow | `#f9e2af` | Warnings |
| Green | `#a6e3a1` | Success |
| Teal | `#94e2d5` | Accents |
| Sky | `#89dceb` | Accents |
| Sapphire | `#74c7ec` | Accents |
| Blue | `#89b4fa` | Links |
| Lavender | `#b4befe` | Accents |
| Text | `#cdd6f4` | Primary text |
| Base | `#1e1e2e` | **Background** |
| Mantle | `#181825` | Secondary background |
| Crust | `#11111b` | Darkest background |

### Window Border Colors

| State | Border Color |
|-------|--------------|
| Focused | Mauve (`#cba6f7`) |
| Focused Inactive | Surface1 (`#45475a`) |
| Unfocused | Surface0 (`#313244`) |
| Urgent | Red (`#f38ba8`) |

---

## Key Bindings

> **Note:** `$mod` = Super/Windows key (Mod4)

### Core Applications

| Keybinding | Action |
|------------|--------|
| `$mod + Return` | Open terminal (Ghostty) |
| `$mod + b` | Open browser (Brave) |
| `$mod + p` | Open application launcher (Rofi) |
| `$mod + n` | Open file manager (Thunar) |

### Window Management

| Keybinding | Action |
|------------|--------|
| `$mod + c` | Close focused window |
| `$mod + f` | Toggle fullscreen |
| `$mod + Shift + Space` | Toggle floating mode |
| `$mod + Space` | Cycle layouts (split → tabbed → stacking) |
| `$mod + v` | Split vertically |
| `$mod + Shift + v` | Split horizontally |

### Focus Navigation

Vim-style and arrow key navigation:

| Keybinding | Action |
|------------|--------|
| `$mod + h` / `$mod + Left` | Focus left |
| `$mod + j` / `$mod + Down` | Focus down |
| `$mod + k` / `$mod + Up` | Focus up |
| `$mod + l` / `$mod + Right` | Focus right |
| `$mod + [` | Focus parent container |
| `$mod + ]` | Focus child container |

### Window Movement

| Keybinding | Action |
|------------|--------|
| `$mod + Shift + h` / `$mod + Shift + Left` | Move window left |
| `$mod + Shift + j` / `$mod + Shift + Down` | Move window down |
| `$mod + Shift + k` / `$mod + Shift + Up` | Move window up |
| `$mod + Shift + l` / `$mod + Shift + Right` | Move window right |

### Workspaces

| Workspace | Icon | Intended Use |
|-----------|------|--------------|
| 1 | `` | Terminal/General |
| 2 | `` | Web Browser |
| 3 | `` | Notes (Obsidian) |
| 4 | `` | Communication (Discord) |
| 5 | `` | Music (Spotify) |
| 6 | `` | Code/Development |
| 7 | `` | Files |
| 8 | `` | Email |
| 9 | `` | Games |
| 10 | `` | Settings |

#### Workspace Navigation

| Keybinding | Action |
|------------|--------|
| `$mod + 1-0` | Switch to workspace 1-10 |
| `$mod + Shift + 1-0` | Move window to workspace 1-10 |
| `$mod + Tab` | Toggle between last two workspaces |
| `$mod + \`` | Next workspace on current output |
| `$mod + Shift + Tab` | Previous workspace on current output |

### Scratchpad

The scratchpad is a hidden workspace for temporarily storing windows:

| Keybinding | Action |
|------------|--------|
| `$mod + Shift + -` | Move window to scratchpad |
| `$mod + -` | Show/hide scratchpad |

### Screenshots

| Keybinding | Action |
|------------|--------|
| `Print` | Full screen screenshot (saved to `~/Pictures/Screenshots/`) |
| `$mod + a` | Custom screenshot script |
| `$mod + s` | Selection screenshot script |
| `Shift + Print` | Screenshot selection to clipboard |

### Media & Hardware Keys

#### Volume Control

| Key | Action |
|-----|--------|
| `XF86AudioMute` | Toggle mute |
| `XF86AudioLowerVolume` | Decrease volume 5% |
| `XF86AudioRaiseVolume` | Increase volume 5% |
| `XF86AudioMicMute` | Toggle microphone mute |

#### Brightness Control

| Key | Action |
|-----|--------|
| `XF86MonBrightnessDown` | Decrease brightness 5% |
| `XF86MonBrightnessUp` | Increase brightness 5% |

#### Media Playback

| Key | Action |
|-----|--------|
| `XF86AudioPlay` | Play/Pause |
| `XF86AudioNext` | Next track |
| `XF86AudioPrev` | Previous track |
| `XF86AudioStop` | Stop playback |

### Quick Actions

| Keybinding | Action |
|------------|--------|
| `$mod + Escape` | Lock screen |
| `$mod + Shift + p` | Clipboard history (Rofi) |
| `$mod + Shift + c` | Color picker (copies hex to clipboard) |
| `$mod + =` | Quick calculator (Rofi calc) |

### Session Management

| Keybinding | Action |
|------------|--------|
| `$mod + Shift + r` | Reload Sway configuration |
| `$mod + Shift + q` | Exit Sway (with confirmation) |

---

## Modes

Modes allow for specialized keybinding contexts. Press `Escape` or `Return` to exit any mode.

### Resize Mode

**Activate:** `$mod + r`

| Keybinding | Action |
|------------|--------|
| `h` / `Left` | Shrink width 20px |
| `j` / `Down` | Grow height 20px |
| `k` / `Up` | Shrink height 20px |
| `l` / `Right` | Grow width 20px |
| `Shift + hjkl` | Fine-grained resize (5px) |

### Power Menu Mode

**Activate:** `$mod + Shift + e`

| Key | Action |
|-----|--------|
| `l` | Lock screen |
| `e` | Exit Sway |
| `s` | Suspend system |
| `r` | Reboot system |
| `p` | Power off system |

### Apps Mode

**Activate:** `$mod + o`

| Key | Application |
|-----|-------------|
| `f` | File Manager (Thunar) |
| `o` | Obsidian |
| `c` | VS Code |
| `d` | Discord |
| `s` | Spotify |

### Tools Mode

**Activate:** `$mod + t`

| Key | Action |
|-----|--------|
| `s` | Start Pomodoro timer |
| `k` | Kill Pomodoro timer |
| `p` | Pause Pomodoro timer |
| `r` | Resume Pomodoro timer |
| `h` | Show next prayer time (Hijri) |
| `e` | Emoji picker (Rofi) |

---

## Input Configuration

### Keyboard

```
Layout:        US English, Arabic
Toggle:        Alt + Shift
Caps Lock:     Remapped to Escape
Repeat Delay:  300ms
Repeat Rate:   50 characters/second
```

### Touchpad

```
Tap to Click:      Enabled
Natural Scroll:    Enabled
Disable While Typing: Enabled
Acceleration:      Adaptive (0.3)
```

### Mouse

```
Acceleration:  Flat (disabled)
Pointer Speed: 0 (raw input)
```

---

## Output Configuration

### Display Settings

- **Wallpaper:** `~/dotfiles/Data/Data/Arabic-Background-HD.webp`
- **Scaling:** Fill mode
- **Adaptive Sync:** Enabled (FreeSync/G-Sync)

---

## Window Rules

### Floating Windows

The following applications open in floating mode:

| Application | Identifier |
|-------------|------------|
| PulseAudio Volume Control | `pavucontrol` |
| Bluetooth Manager | `blueman-manager` |
| Network Settings | `nm-connection-editor` |
| Thunar File Operations | `thunar` (file operation dialogs) |
| Image Viewer | `imv` |
| Media Player | `mpv` |
| LXAppearance | `Lxappearance` |
| Display Settings | `wdisplays` |
| Picture-in-Picture | Any PiP window (also sticky) |

### Workspace Assignments

| Application | Assigned Workspace |
|-------------|-------------------|
| Brave Browser | Workspace 2 |
| Obsidian | Workspace 3 |
| Discord | Workspace 4 |
| Spotify | Workspace 5 |

### Special Behaviors

- **Fullscreen apps inhibit idle:** Screen won't lock while in fullscreen (videos, games, etc.)

---

## Autostart Applications

The following services and applications start automatically with Sway:

| Application | Purpose |
|-------------|---------|
| `pam_kwallet_init` | KDE Wallet authentication |
| `polkit-gnome-authentication-agent` | Privilege escalation dialogs |
| `nm-applet` | Network manager system tray |
| `blueman-applet` | Bluetooth system tray |
| `mako` | Desktop notifications |
| `wl-paste --watch cliphist store` | Clipboard history daemon |
| `autotiling` | Automatic window tiling |
| DBus environment update | Screen sharing support |

---

## Idle & Lock Configuration

The system automatically handles idle states:

| Timeout | Action |
|---------|--------|
| 5 minutes (300s) | Lock screen |
| 10 minutes (600s) | Turn off displays |
| 15 minutes (900s) | Suspend system |

Additional behaviors:
- Screen locks before system sleep
- Displays resume automatically on activity

### Lock Screen

Uses `swaylock` with:
- Wallpaper background
- Fork to background (`-f`)
- Show failed attempts (`-e`)
- Show indicator (`-l`)
- Show caps lock indicator (`-L`)

---

## Custom Scripts

This configuration references several custom scripts:

| Script | Keybinding | Purpose |
|--------|------------|---------|
| `~/scripts/unduck-cli/unduck.sh` | `$mod + i` | DuckDuckGo search utility |
| `~/scripts/books.sh` | `$mod + u` | Book/reading manager |
| `~/scripts/screenshot.sh` | `$mod + a` | Custom screenshot utility |
| `~/scripts/sselp.sh` | `$mod + s` | Selection screenshot |
| `~/scripts/pomodoro.sh` | Tools mode | Pomodoro timer |
| `gopray` | Tools mode | Islamic prayer times |

---

## Customization

### Adding Custom Configurations

Place additional configuration files in:
- `~/.config/sway/config.d/` (user configs)
- `/etc/sway/config.d/` (system-wide configs)

### Modifying the Theme

1. **Change colors:** Edit the color variables in the `VARIABLES` section
2. **Change window decorations:** Modify the `client.*` lines in the `APPEARANCE` section
3. **Change gaps:** Adjust `gaps inner` and `gaps outer` values

### Adding New Keybindings

Use the following format:
```
bindsym --to-code $mod+<key> exec <command>
```

The `--to-code` flag ensures keybindings work regardless of keyboard layout.

### Adding New Window Rules

For floating windows:
```
for_window [app_id="your-app"] floating enable
```

For workspace assignments:
```
assign [app_id="your-app"] $ws<number>
```

Use `swaymsg -t get_tree` to find app_id or class values.

---

## Troubleshooting

### Finding Application Identifiers

Run in terminal:
```bash
swaymsg -t get_tree | grep -E 'app_id|class'
```

### Debugging Keybindings

Check Sway logs:
```bash
journalctl --user -u sway
```

### Testing Configuration Changes

```bash
sway -C -c ~/.config/sway/config
```

### Common Issues

| Issue | Solution |
|-------|----------|
| Keybindings not working | Ensure `--to-code` flag is used |
| Apps not starting | Check if app is installed and in PATH |
| Screen sharing broken | Verify DBus environment is set correctly |
| Clipboard not working | Ensure `wl-paste` is running |

---

## License

This configuration is provided as-is for personal use. Feel free to modify and share.

---

## Credits

- [Sway](https://swaywm.org/) - Tiling Wayland compositor
- [Catppuccin](https://github.com/catppuccin/catppuccin) - Color scheme
- [Nerd Fonts](https://www.nerdfonts.com/) - Icon font
