#
# Whether to enable GTK 2/3 configuration.
#
{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.gtk.enable {
    xdg.systemDirs.data = let
      schema = pkgs.gsettings-desktop-schemas;
    in ["${schema}/share/gsettings-schemas/${schema.name}"];

    home = {
      packages = with pkgs; [
        glib # gsettings
        catppuccin-gtk
        catppuccin-papirus-folders
      ];

      sessionVariables = {
        # set GTK theme to the name specified by the gtk theme package
        GTK_THEME = "catppuccin-mocha-blue-standard+normal"; # "Catppuccin-Mocha-Standard-Blue-dark";

        # gtk applications should use filepickers specified by xdg
        GTK_USE_PORTAL = "${toString (lib.boolToNum true)}";
      };
    };

    gtk = {
      theme = {
        name = "catppuccin-mocha-blue-standard+normal"; # "Catppuccin-Mocha-Standard-Blue-dark";
        package = pkgs.catppuccin-gtk.override {
          variant = "mocha";
          size = "standard";
          accents = ["blue"];
          tweaks = ["normal"];
        };
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          accent = "blue"; # "mauve";
          flavor = "mocha";
        };
      };

      font = {
        name = "Lexend";
        size = 14;
      };

      gtk2 = {
        configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        extraConfig = ''
          gtk-xft-antialias=1
          gtk-xft-hinting=1
          gtk-xft-hintstyle="hintslight"
          gtk-xft-rgba="rgb"
        '';
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-decoration-layout = "appmenu:none";
        gtk-button-images = 1;
        gtk-menu-images = 1;
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-error-bell = 0;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-decoration-layout = "appmenu:none";
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-error-bell = 0;
      };
    };

    # Store GTK css theme in a more easily discoverable location that some
    # applications *might* be smart enough to look at: ~/.config/gtk-4.0
    xdg.configFile = let
      gtk4Dir = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0";
    in {
      "gtk-4.0/assets".source = "${gtk4Dir}/assets";
      "gtk-4.0/gtk.css".source = "${gtk4Dir}/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${gtk4Dir}/gtk-dark.css";
    };
  };
}
