#
# NuShell - a better alternative to zsh/bash with a lot of whistles
#
{
  pkgs,
  osConfig,
  lib,
  ...
}: {
  config = {
    programs = {
      direnv = {
        enable = true;
        enableNushellIntegration = true;
        nix-direnv.enable = true;
      };

      nushell = {
        enable = true;
        shellAliases = let
          g = lib.getExe pkgs.git;
          c = "cargo";
        in {
          # Cargo
          cb = "${c} build";
          cc = "${c} check";
          cn = "${c} new";
          cr = "${c} run";
          cs = "${c} search";
          ct = "${c} test";

          # Git
          ga = "${g} add";
          gc = "${g} commit";
          gd = "${g} diff";
          gl = "${g} log";
          gs = "${g} status";
          gp = "${g} push origin main";

          # ETC.
          c = "clear";
          f = "${pkgs.yazi}/bin/yazi";
          la = "ls -la";
          ll = "ls -l";
          n = "${pkgs.nitch}/bin/nitch";
          nv = "nvim";

          # Nix
          ns = "sudo sh -c 'nixos-rebuild switch --flake $HOME/nixos-config/.#work |& ${pkgs.nix-output-monitor}/bin/nom'";
          nlu = "nix flake lock --update-input";

          # Modern yuunix, uwu <3
          cat = "${pkgs.bat}/bin/bat";
          df = "${pkgs.duf}/bin/duf";
          find = "${pkgs.fd}/bin/fd";
          grep = "${pkgs.ripgrep}/bin/rg";
          tree = "${pkgs.eza}/bin/eza --git --icons --tree";
        };

        environmentVariables = {
          PROMPT_INDICATOR_VI_INSERT = ''"  "'';
          PROMPT_INDICATOR_VI_NORMAL = ''"∙ "'';
          PROMPT_COMMAND = ''""'';
          PROMPT_COMMAND_RIGHT = ''""'';
          DIRENV_LOG_FORMAT = ''""''; # make direnv quiet
          SHELL = ''"${pkgs.nushell}/bin/nu"'';
          EDITOR = ''"nvim"'';
        };

        # See the Nushell docs for more options.
        extraConfig = let
          conf = builtins.toJSON {
            show_banner = false;
            edit_mode = "vi";
            shell_integration = true;

            ls.clickable_links = true;
            rm.always_trash = true;

            table = {
              mode = "rounded";
              index_mode = "always";
              header_on_separator = false;
            };

            cursor_shape = {
              vi_insert = "line";
              vi_normal = "block";
            };

            menus = [
              {
                name = "completion_menu";
                only_buffer_difference = false;
                marker = "? ";
                type = {
                  layout = "columnar"; # list, description
                  columns = 4;
                  col_padding = 2;
                };
                style = {
                  text = "magenta";
                  selected_text = "blue_reverse";
                  description_text = "yellow";
                };
              }
            ];
          };
          completion = name: ''
            source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/${name}/${name}-completions.nu
          '';
          completions = names:
            builtins.foldl' (prev: str: ''
              ${prev}
              ${str}'') "" (map completion names);
        in ''
          $env.config = ${conf};
          ${completions ["git" "nix" "man" "cargo"]}

          def --env ff [...args] {
          	let tmp = (mktemp -t "yazi-cwd.XXXXX")
          	yazi ...$args --cwd-file $tmp
          	let cwd = (open $tmp)
          	if $cwd != "" and $cwd != $env.PWD {
          		cd $cwd
          	}
          	rm -fp $tmp
          }
        '';
      };
    };
  };
}
