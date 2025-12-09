# 🎨 Modern Waybar Configuration for Sway

A sleek, feature-rich Waybar setup with a glassmorphism design inspired by the Catppuccin Mocha color palette.

![Waybar Preview](https://via.placeholder.com/800x50/1e1e2e/cdd6f4?text=Modern+Waybar+for+Sway)

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Requirements](#requirements)
4. [Installation](#installation)
5. [Configuration Structure](#configuration-structure)
6. [Module Reference](#module-reference)
7. [Styling Guide](#styling-guide)
8. [Customization](#customization)
9. [Keybindings Integration](#keybindings-integration)
10. [Troubleshooting](#troubleshooting)
11. [Credits](#credits)

---

## 🌟 Overview

This Waybar configuration provides a modern, floating status bar designed specifically for the Sway window manager. It features:

- **Floating bar design** with rounded corners
- **Glassmorphism aesthetic** with semi-transparent backgrounds
- **Grouped modules** for better organization
- **Interactive elements** with hover effects and click actions
- **Expandable power menu** drawer
- **Responsive states** for system monitoring (warnings, critical alerts)

### Design Philosophy

The configuration follows these principles:
- **Minimalism**: Show only essential information
- **Consistency**: Unified color scheme across all modules
- **Functionality**: Every element is interactive and useful
- **Aesthetics**: Modern design that complements any desktop

---

## ✨ Features

### Visual Features
| Feature | Description |
|---------|-------------|
| Floating Bar | 6px margin from top, 10px from sides |
| Glassmorphism | Semi-transparent background with blur effect |
| Rounded Corners | 12px border radius on main bar, 8px on modules |
| Gradient Accents | Linear gradients on focused/active states |
| Smooth Transitions | 0.3s ease transitions on all hover states |
| Pulse Animations | Animated alerts for critical states |

### Functional Features
| Feature | Description |
|---------|-------------|
| Workspace Icons | Numbered icons with persistent workspaces |
| Window Title Rewriting | App-specific icons for common applications |
| System Monitoring | CPU, Memory, Temperature, Disk with warning states |
| Network Info | WiFi signal strength, Ethernet IP, bandwidth tooltips |
| Bluetooth Integration | Device count, battery percentage display |
| Power Menu Drawer | Expandable menu with lock, suspend, reboot, shutdown |
| Interactive Calendar | Scrollable calendar with week numbers |

---

## 📦 Requirements

### Required Packages

```bash
# Arch Linux / Manjaro
sudo pacman -S waybar sway

# Fedora
sudo dnf install waybar sway

# Ubuntu/Debian (may need additional repos)
sudo apt install waybar sway
```

### Fonts (Required for Icons)

The configuration uses Nerd Font icons. Install one of these:

```bash
# Arch Linux - Recommended
sudo pacman -S ttf-jetbrains-mono-nerd

# Alternative: All Nerd Font symbols
sudo pacman -S ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono

# Fedora
sudo dnf install jetbrains-mono-fonts-all

# Manual Installation (any distro)
# Download from: https://www.nerdfonts.com/font-downloads
# Extract to ~/.local/share/fonts/
# Run: fc-cache -fv
```

### Optional Dependencies

```bash
# Audio control GUI
sudo pacman -S pavucontrol

# Network manager GUI
sudo pacman -S nm-connection-editor

# Bluetooth manager
sudo pacman -S blueman

# Screen brightness control
sudo pacman -S brightnessctl

# Screen locker
sudo pacman -S swaylock swaylock-effects
```

---

## 🚀 Installation

### Quick Install

```bash
# Backup existing config
cp ~/.config/waybar/config.jsonc ~/.config/waybar/config.jsonc.backup
cp ~/.config/waybar/style.css ~/.config/waybar/style.css.backup

# The config files should already be in place
# Restart waybar to apply changes
killall waybar; waybar &
```

### Manual Installation

1. Copy `config.jsonc` to `~/.config/waybar/config.jsonc`
2. Copy `style.css` to `~/.config/waybar/style.css`
3. Restart waybar or reload Sway (`$mod+Shift+c`)

### Sway Configuration

Add this to your `~/.config/sway/config`:

```bash
# Start waybar
bar {
    swaybar_command waybar
}

# Or alternatively:
exec_always --no-startup-id killall waybar; waybar
```

---

## 🏗️ Configuration Structure

### File Layout

```
~/.config/waybar/
├── config.jsonc      # Main configuration (modules, behavior)
├── style.css         # Styling (colors, sizes, animations)
└── README.md         # This documentation
```

### Config.jsonc Structure

```jsonc
{
  // Bar positioning and appearance
  "layer": "top",
  "position": "top",
  "height": 34,
  "margin-top": 6,
  "margin-left": 10,
  "margin-right": 10,

  // Module placement
  "modules-left": [...],
  "modules-center": [...],
  "modules-right": [...],

  // Individual module configurations
  "module-name": { ... }
}
```

---

## 📚 Module Reference

### Left Modules

#### `sway/workspaces`
Displays workspace numbers with clear visual indicators for window state.

| Property | Value | Description |
|----------|-------|-------------|
| `disable-scroll` | `false` | Allow scrolling to switch workspaces |
| `all-outputs` | `true` | Show all workspaces on all monitors |
| `format` | `{name}{icon}` | Display workspace number + icon |
| `persistent-workspaces` | `{"*": 5}` | Always show 5 workspaces |

**Visual States:**
| State | Appearance | Description |
|-------|------------|-------------|
| Empty (persistent) | Dim gray number | No windows on this workspace |
| Has windows | Green number with subtle bg | Workspace contains windows |
| Focused | Blue gradient, bold | Currently active workspace |
| Visible (other monitor) | Light with blue underline | Visible on another output |
| Urgent | Red gradient + pulse | Window needs attention |

#### `sway/mode`
Shows the current Sway mode (resize, binding mode, etc.)

```jsonc
"sway/mode": {
  "format": "<span style=\"italic\" font_weight=\"bold\"> {}</span>"
}
```

#### `sway/scratchpad`
Displays scratchpad window count.

| Icon | Meaning |
|------|---------|
| `` | Scratchpad has windows |
| `󰏃` | Multiple windows |

#### `sway/window`
Shows the focused window title with app-specific icons.

**Rewrite Rules:**
| Pattern | Result |
|---------|--------|
| `* — Mozilla Firefox` | `󰈹 [title]` |
| `* - Visual Studio Code` | `󰨞 [title]` |
| `* - Discord` | `󰙯 [title]` |
| `* - Spotify` | `󰓇 [title]` |
| `*Alacritty` | ` Terminal` |
| `*kitty` | ` Terminal` |
| `*foot` | ` Terminal` |

### Center Modules

#### `clock`
Interactive clock with calendar tooltip.

| Action | Result |
|--------|--------|
| Left Click | Toggle time/date format |
| Right Click | Switch calendar mode |
| Scroll | Navigate calendar months |

**Formats:**
- Default: `󰥔 HH:MM`
- Alternate: `󰃭 Day, Month DD, YYYY`

### Right Modules

#### `tray`
System tray for background applications.

```jsonc
"tray": {
  "icon-size": 16,
  "spacing": 8
}
```

#### `group/hardware`
Grouped system monitoring modules.

##### `cpu`
| State | Threshold | Color |
|-------|-----------|-------|
| Normal | < 70% | Cyan `#89dceb` |
| Warning | 70-90% | Yellow `#f9e2af` |
| Critical | > 90% | Red `#f38ba8` + pulse |

##### `memory`
| State | Threshold | Color |
|-------|-----------|-------|
| Normal | < 70% | Purple `#cba6f7` |
| Warning | 70-90% | Yellow `#f9e2af` |
| Critical | > 90% | Red `#f38ba8` + pulse |

##### `temperature`
| State | Threshold | Color |
|-------|-----------|-------|
| Normal | < 80°C | Orange `#fab387` |
| Critical | ≥ 80°C | Red `#f38ba8` + pulse |

**Icons by temperature:**
- Cool: `󱃃`
- Warm: `󰔏`
- Hot: `󱃂`

##### `disk`
Shows root partition usage with detailed tooltip.

#### `group/audio-network`
Network and audio controls.

##### `pulseaudio`
| Action | Result |
|--------|--------|
| Left Click | Open pavucontrol |
| Right Click | Toggle mute |
| Scroll | Adjust volume (±2%) |

**Icons:**
| State | Icon |
|-------|------|
| Low volume | `󰕿` |
| Medium volume | `󰖀` |
| High volume | `󰕾` |
| Muted | `󰝟` |
| Headphone | `󰋋` |
| Bluetooth | `󰂯` |

##### `network`
| Format | Condition |
|--------|-----------|
| `󰤨 XX%` | WiFi connected |
| `󰈀 IP` | Ethernet connected |
| `󰤭` | Disconnected |

**Actions:**
- Right Click: Open network manager

##### `bluetooth`
| Format | Condition |
|--------|-----------|
| `󰂯` | Bluetooth on |
| `󰂲` | Bluetooth disabled |
| `󰂱 N` | N devices connected |

**Actions:**
- Left Click: Open blueman-manager

#### `group/power-menu`
Expandable drawer with power options.

| Button | Icon | Action |
|--------|------|--------|
| Power | `󰐥` | `systemctl poweroff` |
| Lock | `󰌾` | `swaylock` |
| Suspend | `󰤄` | `systemctl suspend` |
| Reboot | `󰜉` | `systemctl reboot` |
| Exit | `󰗼` | `swaymsg exit` |

---

## 🎨 Styling Guide

### Color Palette (Catppuccin Mocha)

| Color Name | Hex | Usage |
|------------|-----|-------|
| Base | `#1e1e2e` | Main background |
| Surface0 | `#313244` | Module backgrounds |
| Overlay0 | `#6c7086` | Inactive/disabled text |
| Text | `#cdd6f4` | Primary text |
| Subtext0 | `#bac2de` | Secondary text |
| Blue | `#89b4fa` | Primary accent, network |
| Lavender | `#b4befe` | Gradient accents |
| Sky | `#89dceb` | CPU indicator |
| Teal | `#94e2d5` | Disk indicator |
| Green | `#a6e3a1` | Network connected |
| Yellow | `#f9e2af` | Warning states, audio |
| Peach | `#fab387` | Temperature |
| Maroon | `#eba0ac` | Gradient accents |
| Red | `#f38ba8` | Critical states, power |
| Mauve | `#cba6f7` | Memory indicator |
| Pink | `#f5c2e7` | Language indicator |

### CSS Class Reference

#### State Classes
```css
/* Workspace states */
#workspaces button.focused { }    /* Active workspace */
#workspaces button.urgent { }     /* Urgent notification */
#workspaces button.visible { }    /* Visible on output */

/* Module states */
#cpu.warning { }                  /* 70-90% usage */
#cpu.critical { }                 /* >90% usage */
#memory.warning { }
#memory.critical { }
#temperature.critical { }         /* ≥80°C */
#pulseaudio.muted { }
#network.disconnected { }
#bluetooth.disabled { }
#bluetooth.connected { }
#battery.charging { }
#battery.plugged { }
#battery.warning { }
#battery.critical { }
#idle_inhibitor.activated { }
```

### Animation Keyframes

```css
@keyframes pulse {
  0% { opacity: 1; }
  50% { opacity: 0.7; }
  100% { opacity: 1; }
}
```

Used for critical alerts on CPU, memory, temperature, and battery.

---

## 🔧 Customization

### Changing the Color Scheme

To use a different color palette, modify the color values in `style.css`. Here are some alternatives:

#### Nord Theme
```css
/* Replace these colors */
--base: #2e3440;
--text: #eceff4;
--blue: #88c0d0;
--red: #bf616a;
--green: #a3be8c;
--yellow: #ebcb8b;
```

#### Dracula Theme
```css
--base: #282a36;
--text: #f8f8f2;
--blue: #8be9fd;
--red: #ff5555;
--green: #50fa7b;
--yellow: #f1fa8c;
```

### Adding/Removing Modules

#### Add Battery Module (for laptops)
In `config.jsonc`, add `"battery"` to `modules-right`:
```jsonc
"modules-right": [
  "tray",
  "custom/separator",
  "battery",        // Add here
  "group/hardware",
  // ...
]
```

#### Add Backlight Module
```jsonc
"modules-right": [
  // ...
  "backlight",
  "group/audio-network",
  // ...
]
```

#### Add Language Indicator
```jsonc
"modules-right": [
  // ...
  "sway/language",
  "clock",
  // ...
]
```

### Changing Bar Position

```jsonc
// Bottom bar
{
  "position": "bottom",
  "margin-top": 0,
  "margin-bottom": 6,
}

// Left vertical bar
{
  "position": "left",
  "orientation": "vertical",
  "width": 40,
  "height": null,
  "margin-top": 10,
  "margin-bottom": 10,
  "margin-left": 6,
  "margin-right": 0,
}
```

### Changing Font

```css
* {
  font-family: "Your Font Name", "Symbols Nerd Font", sans-serif;
  font-size: 14px;  /* Adjust size */
}
```

### Making the Bar Solid (No Transparency)

```css
window#waybar > box {
  background: #1e1e2e;  /* Remove rgba() */
  border: none;         /* Optional: remove border */
}
```

### Removing the Floating Effect

```jsonc
{
  "margin-top": 0,
  "margin-left": 0,
  "margin-right": 0,
}
```

```css
window#waybar > box {
  border-radius: 0;
}
```

---

## ⌨️ Keybindings Integration

Add these to your `~/.config/sway/config` for full functionality:

```bash
# Audio controls (for keyboard media keys)
bindsym XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
bindsym XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
bindsym XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle

# Brightness controls
bindsym XF86MonBrightnessUp exec brightnessctl set +5%
bindsym XF86MonBrightnessDown exec brightnessctl set 5%-

# Lock screen
bindsym $mod+l exec swaylock

# Power menu (alternative to waybar drawer)
bindsym $mod+Shift+e exec swaynag -t warning -m 'Exit Sway?' -B 'Yes' 'swaymsg exit'
```

---

## 🔍 Troubleshooting

### Icons Not Showing

**Problem:** Icons appear as squares or question marks.

**Solution:**
1. Install a Nerd Font:
   ```bash
   sudo pacman -S ttf-jetbrains-mono-nerd
   ```
2. Rebuild font cache:
   ```bash
   fc-cache -fv
   ```
3. Restart waybar

### CSS Errors on Startup

**Problem:** Waybar shows CSS parsing errors.

**Solution:**
1. Check the error message for line number
2. GTK CSS is more strict than web CSS:
   - Expand shorthand keyframes
   - Use explicit values instead of shorthand
   - Ensure all brackets are closed

### Modules Not Appearing

**Problem:** A module doesn't show in the bar.

**Solution:**
1. Check if the module is in `modules-left/center/right`
2. Verify the module name is correct (case-sensitive)
3. Check if required services are running:
   ```bash
   # For bluetooth
   systemctl status bluetooth
   
   # For network
   systemctl status NetworkManager
   ```

### Temperature Not Showing

**Problem:** Temperature shows as N/A or doesn't appear.

**Solution:**
1. Find your thermal zone:
   ```bash
   cat /sys/class/thermal/thermal_zone*/type
   ```
2. Update `thermal-zone` in config:
   ```jsonc
   "temperature": {
     "thermal-zone": 2,  // Change to correct zone
   }
   ```

### Power Menu Not Expanding

**Problem:** The drawer doesn't open when hovering.

**Solution:**
1. Ensure waybar version is 0.9.17 or newer (drawer support)
2. Check if the drawer transition is set:
   ```jsonc
   "drawer": {
     "transition-duration": 300,
     "transition-left-to-right": false
   }
   ```

### Bar Not Floating

**Problem:** Bar appears attached to screen edge.

**Solution:**
1. Check margin settings in config:
   ```jsonc
   "margin-top": 6,
   "margin-left": 10,
   "margin-right": 10,
   ```
2. Ensure your compositor supports this feature

### Waybar Not Starting with Sway

**Solution:** Add to `~/.config/sway/config`:
```bash
exec_always --no-startup-id waybar
```

Or use the bar block:
```bash
bar {
    swaybar_command waybar
}
```

---

## 🔄 Reloading Configuration

### Reload Waybar Only
```bash
killall waybar; waybar &
```

### Reload Sway (also restarts waybar)
```bash
swaymsg reload
```

### Live CSS Reload
The config includes `"reload_style_on_change": true`, so CSS changes are applied automatically when you save the file.

---

## 📁 Backup and Restore

### Create Backup
```bash
cp ~/.config/waybar/config.jsonc ~/.config/waybar/config.jsonc.backup
cp ~/.config/waybar/style.css ~/.config/waybar/style.css.backup
```

### Restore Backup
```bash
cp ~/.config/waybar/config.jsonc.backup ~/.config/waybar/config.jsonc
cp ~/.config/waybar/style.css.backup ~/.config/waybar/style.css
killall waybar; waybar &
```

---

## 🙏 Credits

- **Color Scheme:** [Catppuccin](https://github.com/catppuccin/catppuccin)
- **Icons:** [Nerd Fonts](https://www.nerdfonts.com/)
- **Waybar:** [Alexays/Waybar](https://github.com/Alexays/Waybar)
- **Sway:** [swaywm/sway](https://github.com/swaywm/sway)

---

## 📄 License

This configuration is provided as-is under the MIT License. Feel free to modify and distribute.

---

*Last updated: December 2024*
