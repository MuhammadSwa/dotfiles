# 🚀 Modern Rofi Configuration

A beautiful, highly customizable, and feature-rich rofi configuration with multiple themes and utility scripts.

<p align="center">
  <img src="https://img.shields.io/badge/Rofi-1.7.x+-blue?style=for-the-badge&logo=linux" alt="Rofi Version"/>
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License"/>
  <img src="https://img.shields.io/badge/Themes-10+-purple?style=for-the-badge" alt="Themes"/>
</p>

---

## 📖 Table of Contents

- [✨ Features](#-features)
- [📦 Prerequisites](#-prerequisites)
- [🔧 Installation](#-installation)
- [🎨 Themes](#-themes)
- [⌨️ Keybindings](#️-keybindings)
- [📜 Scripts](#-scripts)
- [🛠️ Customization](#️-customization)
- [❓ FAQ & Troubleshooting](#-faq--troubleshooting)
- [📚 Resources](#-resources)

---

## ✨ Features

- **🎨 10+ Beautiful Themes** - Including Catppuccin, Dracula, Nord, Gruvbox, Tokyo Night, and more
- **⚡ Fuzzy Matching** - Fast, intelligent searching with fzf-style matching
- **🎹 Vim-style Keybindings** - Navigate with `j/k`, `Ctrl+f/b`, and more
- **📱 Modern UI** - Rounded corners, icons, smooth animations
- **🔧 Utility Scripts** - Power menu, screenshot tool, network manager, theme switcher
- **🖼️ Icon Support** - Full Nerd Font icon integration
- **🌐 Wayland & X11** - Works on both display servers
- **📁 Organized Structure** - Clean, modular file organization

---

## 📦 Prerequisites

### Required

- **Rofi** (1.7.0 or higher, wayland version recommended for Wayland users)
- **A Nerd Font** (JetBrainsMono Nerd Font recommended)

### Recommended

- **Papirus Icon Theme** - For beautiful application icons
- **A compositor with blur support** - For glass theme (picom, hyprland, etc.)

### For Scripts

| Script | Dependencies |
|--------|-------------|
| `powermenu.sh` | `systemctl`, screen locker (swaylock/hyprlock/i3lock) |
| `screenshot.sh` | `grim + slurp` (Wayland) or `scrot/maim` (X11), `wl-copy/xclip` |
| `network.sh` | `NetworkManager`, `nmcli` |
| `theme-switcher.sh` | `notify-send` |

### Installation Commands

```bash
# Arch Linux
sudo pacman -S rofi papirus-icon-theme ttf-jetbrains-mono-nerd
yay -S rofi-lbonn-wayland  # For Wayland users

# Fedora
sudo dnf install rofi papirus-icon-theme
# Install Nerd Font manually from: https://www.nerdfonts.com/

# Ubuntu/Debian
sudo apt install rofi papirus-icon-theme
# Install Nerd Font manually from: https://www.nerdfonts.com/

# Screenshot tools (Wayland)
sudo pacman -S grim slurp wl-clipboard

# Screenshot tools (X11)
sudo pacman -S scrot xclip
```

---

## 🔧 Installation

### Quick Install

```bash
# Backup existing config
mv ~/.config/rofi ~/.config/rofi.backup

# Clone or copy this configuration
git clone <repo-url> ~/.config/rofi
# Or simply copy all files to ~/.config/rofi/

# Make scripts executable
chmod +x ~/.config/rofi/scripts/*.sh
```

### Manual Install

1. Copy `config.rasi` to `~/.config/rofi/`
2. Copy the `themes/` directory to `~/.config/rofi/themes/`
3. Copy the `scripts/` directory to `~/.config/rofi/scripts/`
4. Make scripts executable: `chmod +x ~/.config/rofi/scripts/*.sh`

---

## 🎨 Themes

### Available Themes

| Theme | Description | Style |
|-------|-------------|-------|
| **catppuccin-mocha** | Soothing pastel colors | Dark, rounded |
| **dracula** | Classic Dracula palette | Dark, purple accent |
| **nord** | Arctic, north-bluish | Dark, blue accent |
| **gruvbox** | Retro groove colors | Dark, orange/yellow |
| **tokyo-night** | Tokyo nightlife inspired | Dark, blue accent |
| **rose-pine** | Natural pine, soho vibes | Dark, rose accent |
| **minimal-dark** | Clean, distraction-free | Minimal, monochrome |
| **glass** | Glassmorphism design | Transparent, blur |
| **powermenu** | Power menu layout | Horizontal icons |
| **launcher** | Fullscreen launcher | Grid layout |

### Switching Themes

**Option 1: Edit config.rasi**

```rasi
/* Change this line at the bottom of config.rasi */
@theme "themes/dracula.rasi"
```

**Option 2: Use the theme switcher script**

```bash
~/.config/rofi/scripts/theme-switcher.sh
```

**Option 3: Command line**

```bash
rofi -show drun -theme ~/.config/rofi/themes/nord.rasi
```

### Theme Previews

<details>
<summary>📸 Click to expand theme previews</summary>

#### Catppuccin Mocha (Default)
A soothing pastel theme with rounded corners and mauve accent.

#### Dracula
The classic Dracula theme with purple highlights.

#### Nord
Arctic-inspired theme with clean lines and blue accents.

#### Gruvbox
Retro groove colors with a warm, nostalgic feel.

#### Tokyo Night
Inspired by Tokyo's nightlife with vibrant blues.

#### Rosé Pine
All natural pine with rose gold accents.

#### Minimal Dark
Ultra-clean, distraction-free design.

#### Glass
Modern glassmorphism with blur effect (requires compositor).

</details>

---

## ⌨️ Keybindings

### Navigation

| Key | Action |
|-----|--------|
| `j` / `Down` / `Ctrl+n` | Move down |
| `k` / `Up` / `Ctrl+p` | Move up |
| `Ctrl+j` | Move down (alternative) |
| `Ctrl+k` | Move up (alternative) |
| `Ctrl+f` / `Page Down` | Page down |
| `Ctrl+b` / `Page Up` | Page up |
| `Home` | Jump to first |
| `End` | Jump to last |

### Actions

| Key | Action |
|-----|--------|
| `Return` / `Enter` | Select item |
| `Escape` / `Ctrl+c` | Cancel/Close |
| `Ctrl+Tab` / `Ctrl+l` | Next mode |
| `Ctrl+Shift+Tab` / `Ctrl+h` | Previous mode |
| `Tab` | Next element |
| `Shift+Tab` | Previous element |

### Editing

| Key | Action |
|-----|--------|
| `Ctrl+BackSpace` | Delete word back |
| `Ctrl+Delete` | Delete word forward |
| `Ctrl+u` | Clear line |
| `Ctrl+a` | Move to start |
| `Ctrl+e` | Move to end |

---

## 📜 Scripts

### Power Menu

A beautiful power menu with options for shutdown, reboot, lock, suspend, and logout.

```bash
~/.config/rofi/scripts/powermenu.sh
```

**Keybind suggestion (Hyprland):**
```conf
bind = $mainMod, X, exec, ~/.config/rofi/scripts/powermenu.sh
```

### Screenshot Menu

Quick screenshot options with multiple capture modes.

```bash
~/.config/rofi/scripts/screenshot.sh
```

**Features:**
- Full screen capture
- Selection capture
- Active window capture
- 5-second timer
- Copy to clipboard

**Keybind suggestion:**
```conf
bind = , Print, exec, ~/.config/rofi/scripts/screenshot.sh
```

### Network Manager

WiFi network management through rofi.

```bash
~/.config/rofi/scripts/network.sh
```

**Features:**
- Toggle WiFi on/off
- Scan for networks
- Connect to networks
- Password input for new networks

### Theme Switcher

Easily switch between available themes.

```bash
~/.config/rofi/scripts/theme-switcher.sh
```

---

## 🛠️ Customization

### Changing the Font

Edit `config.rasi`:

```rasi
configuration {
    font: "Your Font Name 12";
}
```

**Popular choices:**
- `JetBrainsMono Nerd Font`
- `FiraCode Nerd Font`
- `Hack Nerd Font`
- `SF Pro Display`
- `Inter`

### Changing the Icon Theme

Edit `config.rasi`:

```rasi
configuration {
    icon-theme: "Your-Icon-Theme";
}
```

**Popular choices:**
- `Papirus-Dark`
- `Papirus`
- `Adwaita`
- `Tela`
- `Qogir`

### Adjusting Window Size

In your theme file, modify the `window` section:

```rasi
window {
    width: 700px;     /* Wider window */
    /* Or use percentage */
    width: 50%;
}
```

### Changing Number of Visible Items

In your theme file, modify the `listview` section:

```rasi
listview {
    lines: 10;        /* Show 10 items */
    columns: 2;       /* Use 2 columns */
}
```

### Adding Custom Colors

Create your own theme or modify existing ones:

```rasi
* {
    /* Define your colors */
    my-background: #1a1a2e;
    my-foreground: #eaeaea;
    my-accent: #e94560;
    
    /* Apply them */
    background: @my-background;
    foreground: @my-foreground;
    selected: @my-accent;
}
```

### Creating a Custom Theme

1. Copy an existing theme:
   ```bash
   cp ~/.config/rofi/themes/catppuccin-mocha.rasi ~/.config/rofi/themes/my-theme.rasi
   ```

2. Edit the colors and styles in your new theme

3. Update `config.rasi` to use your theme:
   ```rasi
   @theme "themes/my-theme.rasi"
   ```

---

## ❓ FAQ & Troubleshooting

### Icons not showing?

1. Make sure you have a Nerd Font installed
2. Verify the font is set correctly in `config.rasi`
3. Check if your icon theme is installed:
   ```bash
   ls /usr/share/icons/ | grep -i papirus
   ```

### Blur not working with glass theme?

The glass theme requires a compositor with blur support:

**For Hyprland**, add to your config:
```conf
decoration {
    blur {
        enabled = true
        size = 8
        passes = 2
    }
}
```

**For Picom**, add to your config:
```conf
blur-method = "dual_kawase";
blur-strength = 7;
```

### Rofi won't launch?

1. Check for syntax errors:
   ```bash
   rofi -show drun 2>&1 | head -20
   ```

2. Test with default theme:
   ```bash
   rofi -show drun -theme /dev/null
   ```

3. Verify rofi version:
   ```bash
   rofi -version
   ```

### Keybindings not working?

Some keybindings might conflict with your window manager. Check your WM config for conflicts or modify the keybindings in `config.rasi`.

### Wrong colors on Wayland?

Make sure you're using the Wayland version of rofi:
```bash
# Arch
yay -S rofi-lbonn-wayland
```

### Scripts not executable?

```bash
chmod +x ~/.config/rofi/scripts/*.sh
```

---

## 📁 Directory Structure

```
~/.config/rofi/
├── config.rasi              # Main configuration
├── current.rasi             # Previous/backup theme (can be removed)
├── README.md                # This file
├── themes/                  # Theme files
│   ├── catppuccin-mocha.rasi
│   ├── dracula.rasi
│   ├── nord.rasi
│   ├── gruvbox.rasi
│   ├── tokyo-night.rasi
│   ├── rose-pine.rasi
│   ├── minimal-dark.rasi
│   ├── glass.rasi
│   ├── powermenu.rasi
│   ├── confirm.rasi
│   └── launcher.rasi
├── scripts/                 # Utility scripts
│   ├── powermenu.sh
│   ├── theme-switcher.sh
│   ├── screenshot.sh
│   └── network.sh
└── images/                  # Banner images (optional)
    └── banner.png
```

---

## 🎯 Quick Commands

```bash
# Application launcher
rofi -show drun

# Run prompt
rofi -show run

# Window switcher
rofi -show window

# File browser
rofi -show filebrowser

# All modes combined
rofi -show combi -combi-modes "drun,run,window"

# With specific theme
rofi -show drun -theme ~/.config/rofi/themes/dracula.rasi

# Power menu
~/.config/rofi/scripts/powermenu.sh

# Screenshot
~/.config/rofi/scripts/screenshot.sh

# Network
~/.config/rofi/scripts/network.sh

# Theme switcher
~/.config/rofi/scripts/theme-switcher.sh
```

---

## 📚 Resources

- [Rofi Official Documentation](https://github.com/davatorium/rofi)
- [Rofi Themes Collection](https://github.com/adi1090x/rofi)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [Dracula Theme](https://draculatheme.com/)
- [Nord Theme](https://www.nordtheme.com/)
- [Gruvbox](https://github.com/morhetz/gruvbox)
- [Tokyo Night](https://github.com/enkia/tokyo-night-vscode-theme)
- [Rosé Pine](https://rosepinetheme.com/)
- [Nerd Fonts](https://www.nerdfonts.com/)
- [Papirus Icons](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)

---

## 📄 License

This configuration is released under the MIT License. Feel free to use, modify, and distribute.

---

## 🙏 Credits

- Color schemes from their respective creators
- Icons from Nerd Fonts and Papirus
- Inspired by various rofi configs from the r/unixporn community

---

<p align="center">
  Made with ❤️ for the Linux community
</p>

<p align="center">
  <sub>If you like this config, consider giving it a ⭐</sub>
</p>
