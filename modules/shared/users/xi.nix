{
  keys,
  pkgs,
  ...
}: {
  users.users.xi = {
    isNormalUser = true;

    # Home directory
    createHome = true;
    home = "/home/xi";

    shell = pkgs.zsh;

    # Should be generated manually. See option documentation
    # for tips on generating it. For security purposes, it's
    # a good idea to use a non-default hash.
    # To create the password hashes, use
    # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
    # initialHashedPassword = "$2b$05$BzxF5/YnEdPRSLTWbvVZz.ThWxyGJYgkN12d0J2Zj2YFrlckPYIYS"; #FIXME - keep getting incorrect password
    initialPassword = "changeme";
    openssh.authorizedKeys.keys = [keys.xi];
    extraGroups = [
      "wheel"
      "systemd-journal"
      "audio"
      "video"
      "input"
      "plugdev"
      "lp"
      "tss"
      "power"
      "nix"
      "network"
      "networkmanager"
      "wireshark"
      "mysql"
      "docker"
      "podman"
      "git"
      "libvirtd"
    ];
  };
}
