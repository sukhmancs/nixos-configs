{...}: {
  home-manager = {
    users.xi = {
      home = {
        username = "xi";
        homeDirectory = "/home/xi";
        # The initial version of Home Manager configuration, should not be changed after set
        stateVersion = "23.05";
      };

      programs.home-manager.enable = true;
      systemd.user.startServices = "sd-switch"; # or "legacy" if "sd-switch" breaks again
    };
  };
}
