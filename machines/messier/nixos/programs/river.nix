{
  pkgs,
  config,
  ...
}:
# https://github.com/viperML/wrapper-manager/issues/14
# pkgs.symlinkJoin {
#   name = "river-wrapped";
#   paths = [pkgs.river];
#   buildInputs = [pkgs.makeWrapper];
#   postBuild = ''
#     wrapProgram $out/bin/river --add-flags "-c ${import ./init.nix {inherit pkgs config;}}";
#   '';
# }
{
  programs.river = {
    enable = true;
    package = pkgs.river;
  };
}
