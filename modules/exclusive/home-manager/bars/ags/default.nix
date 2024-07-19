{
  inputs,
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (osConfig) modules;
  inherit (lib) mkIf;

  cfg = modules.home.programs;

  theme = import ./theme.nix;
  settings = {
    system = "x86_64-linux";
  };

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
    pkgs.callPackage ./configs/default.nix {
      inherit inputs writeShellScript stdenv cage swww esbuild dart-sass fd fzf brightnessctl accountsservice slurp wf-recorder wl-clipboard wayshot swappy hyprpicker pavucontrol networkmanager gtk3 which gtksourceview;
      inherit (settings) system;
    };
in {
  config = mkIf cfg.ags.enable {
    home-manager.users.xi = {
      imports = [
        inputs.ags.homeManagerModules.default
        ./theme.nix
      ];
      home.packages = with pkgs; [
        asztal
        bun
        fd
        dart-sass
        gtk3
        pulsemixer
        networkmanager
        gtksourceview
        ollama
        pywal
        sassc
        (python311.withPackages (p: [
          p.material-color-utilities
          p.pywayland
        ]))
      ];

      programs.ags = {
        enable = true;
        configDir = null; #./configs;

        extraPackages = with pkgs; [
          gtksourceview
          gtksourceview4
          ollama
          python311Packages.material-color-utilities
          python311Packages.pywayland
          pywal
          sassc
          webkitgtk
          webp-pixbuf-loader
          ydotool
        ];
      };

      home.file.".config/ags" = {
        source = ./configs;
        recursive = true;
      };
    };
  };
}
