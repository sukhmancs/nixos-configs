{
  pkgs,
  inputs',
  config,
}:
with pkgs; [
  (inputs'.agenix.packages.default.override {ageBin = "${pkgs.rage}/bin/rage";}) # provide agenix CLI within flake shell
  config.treefmt.build.wrapper # A tree-wide formatter
  nil # Nix Language Server (provides error checking, and other error handling)
  alejandra # A formatter for Nix files
  git # Source control
  glow # A markdown viewer
  statix # A linter for nix
  deadnix # Remove dead code from nix files
  nodejs # Required for various JavaScript-based tools including ags and eslint_d
]
