#
# Override - enable git signing by default
#
{lib, ...}: let
  inherit (lib) mkForce;
in {
  home-manager.users.xi = {
    programs.git = {
      enable = mkForce true;
      signing = {
        key = mkForce "EB28A227A8C9E8F0";
        signByDefault = mkForce true;
      };
    };
  };
}
