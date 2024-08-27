{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    # Enable qemu - this is required for VPS to work
    virtualisation.libvirtd.enable = true;

    # Nixos Cache - Harmonia
    services.harmonia.enable = true;

    # Matrix Synapse - Private Chat Server
    services.matrix-synapse.enable = true;

    # Mastodon - Social Media Server
    services.mastodon.enable = true;

    # Wireguard Server Configuration
    networking.wireguard.enable = true;

    #TODO: configure tailscale for server - override flags for server (check modules/exclusive/nixos/shared/tailscale-client)
    # services.tailscale.enable = false;

    # This have performance impact
    # services.endlessh-go.enable = false; # tarpit

    modules.system = {
      mainUser = "xi";
    };
  };
}
