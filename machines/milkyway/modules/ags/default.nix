{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  settings = {
    system = "x86_64-linux";
    hostname = "alfheim"; # Hostname
    username = "xi";
    profile = "desktop"; # Select from profiles directory
    timezone = "Europe/Moscow"; # Select timezone
    locale = "en_US.UTF-8"; # Select locale
    name = "Xi Lain"; # Name (git config)
    email = "n.zheleztsov@proton.me"; # Email (git config)
    dotfilesDir = "/home/xi/.config/nixos-configs"; # Absolute path of the local repo
    theme = "catppuccin"; # Selected theme from themes directory (./themes/)
    themeDetails = import (./. + "/mochatheme.nix") {dir = settings.dotfilesDir;};
    wm = ["hyprland" "kde"]; # Selected window manager or desktop environment;
    # must select one in both ./user/wm/ and ./system/wm/
    # Note, that first WM is incldued included into work profile
    # second one includes both.

    font = "JetBrains Mono"; # Selected font
    fontPkg = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
    fontSize = 12; # Font size
    icons = "Papirus";
    iconsPkg = pkgs.papirus-icon-theme;

    # Session variables.
    editor = "nvim"; # Default editor
    editorPkg = pkgs.neovim;
    browser = "firefox"; # Default browser; must select one from ./user/app/browser/
    browserPkg = pkgs.firefox;
    term = "kitty"; # Default terminal command
    termPkg = pkgs.kitty;
  };

  details = settings.themeDetails;
  asztal = let
    writeShellScript = pkgs.writeShellScript;
    stdenv = pkgs.stdenv;
    cage = pkgs.cage;
    swww = pkgs.swww;
    esbuild = pkgs.esbuild;
    dart-sass = pkgs.dart-sass;
    fd = pkgs.fd;
    fzf = pkgs.fzf;
    brightnessctl = pkgs.brightnessctl;
    accountsservice = pkgs.accountsservice;
    slurp = pkgs.slurp;
    wf-recorder = pkgs.wf-recorder;
    wl-clipboard = pkgs.wl-clipboard;
    wayshot = pkgs.wayshot;
    swappy = pkgs.swappy;
    hyprpicker = pkgs.hyprpicker;
    pavucontrol = pkgs.pavucontrol;
    networkmanager = pkgs.networkmanager;
    gtk3 = pkgs.gtk3;
    which = pkgs.which;
    gtksourceview = pkgs.gtksourceview;
  in
    pkgs.callPackage ../../../../modules/exclusive/home-manager/bars/ags/default.nix {
      inherit inputs writeShellScript stdenv cage swww esbuild dart-sass fd fzf brightnessctl accountsservice slurp wf-recorder wl-clipboard wayshot swappy hyprpicker pavucontrol networkmanager gtk3 which gtksourceview;
      inherit (settings) system;
    };
  agsColors = {
    wallpaper = details.wallpaper;
    theme = {
      blur = (1 - details.opacity) * 100;
      radius = details.rounding;
      shadows = details.shadow;
      palette = {
        primary = {
          bg = "#2E3440"; # Changed from base0D to a new color
          fg = "#D8DEE9"; # Changed from base00 to a new color
        };
        secondary = {
          bg = "#BF616A"; # Changed from base0E to a new color
          fg = "#ECEFF4"; # Changed from base00 to a new color
        };
        error = {
          bg = "#A3BE8C"; # Changed from base06 to a new color
          fg = "#E5E9F0"; # Changed from base00 to a new color
        };
        bg = "#4C566A"; # Changed from base00 to a new color
        fg = "#81A1C1"; # Changed from base05 to a new color
        widget = "#88C0D0"; # Changed from base05 to a new color
        border = "#8FBCBB"; # Changed from base05 to a new color
      };
    };
    font = {
      size = settings.fontSize;
      name = "${settings.font}";
    };
    widget = {
      opacity = details.opacity * 100;
    };
  };
  agsOptions = lib.recursiveUpdate agsColors details.ags;
in {
  config = {
    home-manager.users.xi = {
      imports = [inputs.ags.homeManagerModules.default];
      home.packages = with pkgs; [
        asztal
        bun
        fd
        dart-sass
        gtk3
        pulsemixer
        networkmanager
        gtksourceview
      ];

      programs.ags = {
        enable = true;
        configDir = ../../../../modules/exclusive/home-manager/bars/ags;
      };

      home.file.".cache/ags/options-nix.json".text = builtins.toJSON agsOptions;
    };
  };
}
