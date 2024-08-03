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
    # If option Impermanence is enabled, the hashedPasswordFile is used
    # instead, so this option is ignored because of precedence.
    # initialHashedPassword = "$2b$05$3sBXYiZC2RifZXJawMctfewnKzErqiK8MW0uEixXZ7hk9qvnMbmGK";
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
