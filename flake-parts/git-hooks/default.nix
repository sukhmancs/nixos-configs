#
# Git hooks configuration
#
# Usage:
#   nix flake check
#
{
  perSystem = {
    pkgs,
    inputs',
    ...
  }: let
    excludes = ["flake.lock" "r'.+\.age$'" "r'.+\.sh$'" "r'themes(/.*)?$'" "r'flake-parts(/.*)?$'"];

    # The core of this configuration is the makeHook function, which generates configurations for individual hooks
    # based on provided arguments (args).
    # Parameters: args - An attribute set containing configurations specific to each hook.
    # Behavior:
    # commonSettings: Defines settings common to all hooks, including the inherited excludes list,
    # a dynamic description based on the hook's name, and several flags (fail_fast, verbose, enable).
    # specificSettings: Extracts settings specific to the hook by removing the name attribute from args.
    # finalExcludes: Determines the final list of patterns to exclude. If args includes extraExcludes,
    # they are appended to the base excludes list; otherwise, the base excludes list is used.
    # Returns: An attribute set combining commonSettings, specificSettings, and the excludes configuration.
    makeHook = args: let
      commonSettings = {
        inherit excludes;
        description = "pre-commit hook for ${args.name}";
        fail_fast = true;
        verbose = true;
        enable = true;
      };
      specificSettings = builtins.removeAttrs args ["name" "extraExcludes"];
      finalExcludes =
        if args ? extraExcludes && args.extraExcludes != []
        then excludes ++ args.extraExcludes
        else excludes;
    in
      commonSettings
      // specificSettings
      // {
        excludes = finalExcludes;
      };
  in {
    pre-commit = {
      check.enable = true;

      settings = {
        inherit excludes;

        hooks = {
          # alejandra = makeHook {
          #   name = "alejandra";
          # package = inputs'.nyxpkgs.packages.alejandra-no-ads;
          # };
          exiftool = makeHook {
            name = "exiftool";
            types = ["image"];
            entry = ''
              ${pkgs.exiftool}/bin/exiftool \
                  -all= --icc_profile:all -tagsfromfile @ -orientation -overwrite_original
            '';
          };
          prettier = makeHook {
            name = "prettier";
            settings = {
              binPath = "${pkgs.prettierd}/bin/prettierd";
              write = true;
            };
          };
          actionlint = makeHook {name = "actionlint";};
          luacheck = makeHook {name = "luacheck";};
          treefmt = makeHook {name = "treefmt";};
          lychee = makeHook {
            name = "lychee";
            extraExcludes = ["^(?!.*\\.md$).*"];
          };
          editorconfig-checker = makeHook {
            name = "editorconfig";
            enable = false;
            always_run = true;
          };
        };
      };
    };
  };
}
