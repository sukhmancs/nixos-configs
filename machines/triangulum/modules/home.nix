{lib, ...}: let
  inherit (lib) mkForce;
in {
  config = {
    home-manager.users.xi = {
      programs.foot.enable = mkForce false;
    };
  };
}
