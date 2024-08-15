{
  self,
  config,
  lib,
  ...
}: let
  inherit (self) inputs;
  inherit (lib.modules) mkIf;
  inherit (lib.attrsets) genAttrs;

  specialArgs = {inherit inputs self;};
in {
  home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm.backup";
    extraSpecialArgs = specialArgs;

    users.nixos = {
      imports = [
        ./homes
      ];

      home = {
        username = "nixos";
        homeDirectory = lib.mkForce "/home/nixos";
        stateVersion = "23.05";
      };

      manual = {
        manpages.enable = false;
        html.enable = false;
        json.enable = false;
      };

      programs.home-manager.enable = true;
      # Configure systemd to reload user services upon configuration changes
      systemd.user.startServices = "sd-switch"; # or "legacy" if "sd-switch" breaks again
    };
  };
}
