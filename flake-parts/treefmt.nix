#
# treefmt - A tree-wide formatter
#
{
  perSystem = {
    inputs',
    config,
    pkgs,
    ...
  }: {
    treefmt = {
      projectRootFile = "flake.nix";

      programs = {
        alejandra = {
          enable = true;
          package = inputs'.nyxpkgs.packages.alejandra-no-ads;
        };
        black.enable = true;
        deadnix.enable = false;
        shellcheck.enable = true;
        shfmt = {
          enable = true;
          indent_size = 4;
        };
        prettier = {
          enable = true;
          package = pkgs.prettierd;
          excludes = ["*.age"];
          settings = {
            editorconfig = true;
          };
        };
      };
    };
  };
}
