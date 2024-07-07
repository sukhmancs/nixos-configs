{
  config,
  lib,
  ...
}: let
  inherit (builtins) elemAt;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.modules) mkMerge;
  inherit (lib.lists) optionals;
  inherit (lib.types) enum listOf str nullOr bool package;
in {
  imports = [
    # configuration options for nixos activation scripts
    ./activation.nix
    ./impermanence.nix

    # network and overall hardening
    ./networking
    ./encryption.nix

    # filesystems
    ./fs.nix

    # package and program related options
    ./services
  ];

  options.modules.system = {
    # mainUser is required by many services that needs the current usrname
    mainUser = mkOption {
      type = str;
      default = "xi";
      description = ''
        The username of the main user for your system.
      '';
    };
  };
}
