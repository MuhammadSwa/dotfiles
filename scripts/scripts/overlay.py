#!/usr/bin/env python3
import gi
gi.require_version('Gtk', '3.0')
gi.require_version('GtkLayerShell', '0.1')
from gi.repository import Gtk, GtkLayerShell, GLib, WebKit2
import subprocess
import sys

class OverlayWindow(Gtk.Window):
    def __init__(self, script_path):
        super().__init__(title="Sway Overview")
        self.script_path = script_path

        # Configure as a layer-shell window
        GtkLayerShell.init_for_window(self)
        GtkLayerShell.set_layer(self, GtkLayerShell.Layer.OVERLAY)
        GtkLayerShell.set_exclusive_zone(self, 0)
        GtkLayerShell.set_keyboard_interactivity(self, False) # Don't steal keyboard focus

        # Anchor to center
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.TOP, True)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.BOTTOM, True)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.LEFT, True)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.RIGHT, True)

        self.set_default_size(800, 600) # Adjust size as needed
        self.set_decorated(False) # No window decorations

        # Create a WebView to render HTML
        self.webview = WebKit2.WebView()
        self.add(self.webview)

        self.connect("destroy", Gtk.main_quit)

        # Load initial content
        self.update_content()

        # Optional: Set up a timer to periodically update content
        # GLib.timeout_add_seconds(5, self.update_content)

    def update_content(self):
        try:
            # Run the shell script and capture its output
            result = subprocess.run([self.script_path], capture_output=True, text=True, check=True)
            html_content = f"""
            <!DOCTYPE html>
            <html>
            <head>
                <style>
                    body {{
                        background-color: rgba(26, 26, 26, 0.9); /* Your background, slightly transparent */
                        color: #f5f5f5; /* Off-White */
                        font-family: sans-serif;
                        padding: 20px;
                        border-radius: 10px;
                        border: 2px solid #4b0082; /* Deep Indigo */
                    }}
                    h2, h3 {{
                        color: #ffd700; /* Gold */
                        text-align: center;
                    }}
                    hr {{
                        border-color: #2c2c2c; /* Dark Gray */
                    }}
                    ul {{
                        list-style: none;
                        padding-left: 10px;
                    }}
                    li {{
                        margin-bottom: 5px;
                    }}
                    span {{
                        font-weight: bold;
                    }}
                </style>
            </head>
            <body>
                {result.stdout}
            </body>
            </html>
            """
            self.webview.load_html(html_content, "file:///")
        except subprocess.CalledProcessError as e:
            print(f"Error running script: {e}", file=sys.stderr)
            self.webview.load_html(f"<h1>Error: {e.stderr}</h1>", "file:///")
        return True

if __name__ == "__main__":
    script_to_run = GLib.get_home_dir() + "/scripts/sway-overview.sh"
    win = OverlayWindow(script_to_run)
    win.show_all()
    Gtk.main()
