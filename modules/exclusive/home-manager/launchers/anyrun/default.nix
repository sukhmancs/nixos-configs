{
  inputs,
  inputs',
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  theme = import ./theme.nix {
    inherit osConfig pkgs;
  };

  env = modules.home;
in {
  imports = [inputs.anyrun.homeManagerModules.default];
  config = mkIf env.programs.anyrun.enable {
    programs.anyrun = {
      enable = true;
      config = {
        plugins = with inputs'.anyrun.packages; [
          applications
          rink
          translate
          shell
          # randr
          symbols
          translate
          dictionary

          inputs'.anyrun-nixos-options.packages.default
        ];

        # x and y are the position of the main box
        x.fraction = 0.500000;
        y.absolute = 15;

        width.fraction = 0.300000;
        height.absolute = 0;
        hideIcons = false;
        ignoreExclusiveZones = false;
        layer = "overlay";
        hidePluginInfo = true;
        closeOnClick = true;
        showResultsImmediately = false;
        maxEntries = null;
      };

      extraConfigFiles = {
        "applications.ron".text = ''
          Config(
            // Also show the Desktop Actions defined in the desktop files, e.g. "New Window" from LibreWolf
            desktop_actions: true,
            max_entries: 10,
            // The terminal used for running terminal based desktop entries, if left as `None` a static list of terminals is used
            // to determine what terminal to use.
            terminal: Some("foot"),
          )
        '';

        "randr.ron".text = ''
          Config(
            prefix: ":ra",
            max_entries: 5,
          )
        '';

        "symbols.ron".text = ''
          Config(
            // The prefix that the search needs to begin with to yield symbol results
            prefix: ":sy",

            // Custom user defined symbols to be included along the unicode symbols
            symbols: {
              // "name": "text to be copied"
              "shrug": "¯\\_(ツ)_/¯",
            },

            // The number of entries to be displayed
            max_entries: 5,
          )
        '';

        "translate.ron".text = ''
          Config(
            prefix: ":tr",
            language_delimiter: ">",
            max_entries: 3,
          )
        '';

        "dictionary.ron".text = ''
          Config(
            prefix: ":d",
            max_entries: 5,
          )
        '';

        "shell.ron".text = ''
          Config(
            prefix: ":sh",
            shell: "zsh",
            max_entries: 5,
          )
        '';

        "nixos-options.ron".text = let
          nixos-options = osConfig.system.build.manual.optionsJSON + "/share/doc/nixos/options.json";
          hm-options = inputs'.home-manager.packages.docs-json + "/share/doc/home-manager/options.json";
          options = builtins.toJSON {
            ":nix" = [nixos-options];
            ":hm" = [hm-options];
            ":nall" = [nixos-options hm-options];
          };
        in ''
          Config(
            options: ${options},
            min_score: 5,
            max_entries: Some(3),
          )
        '';
      };

      # this compiles the SCSS file from the given path into CSS
      # by default, `-t expanded` as the args to the sass compiler
      # extraCss = builtins.readFile (lib.compileSCSS pkgs {
      #   name = "style-dark";
      #   source = ./styles/dark.scss;
      # });

      extraCss = builtins.readFile ./styles/dark.css;
    };
    home.file.".config/anyrun/variables.scss".text = builtins.readFile theme;
  };
}
