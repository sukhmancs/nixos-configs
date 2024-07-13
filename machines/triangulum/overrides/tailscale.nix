#
# TailScale override - Updated flags for server
#
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkForce;

  endpoint = "https://hs.xilain.dev";
  operator = config.modules.system.mainUser;
  tags = ["tag:server"];
in {
  config.services.tailscale = {
    enable = true;
    extraUpFlags = mkForce [
      "--ssh"
      "--authkeyfile:${config.age.secrets.tailscale-client.path}"
      "--login-server ${endpoint}"
      "--operator ${operator}"
      "--advertise-tags ${lib.concatStringsSep "," tags}"
      "--advertise-exit-node"
    ];
  };
}
