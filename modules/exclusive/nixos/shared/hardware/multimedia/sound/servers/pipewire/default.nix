{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib.modules) mkIf;

  inherit (config) modules;
  dev = modules.device;
in
{
  imports = [
    ./wireplumber

    #./low-latency.nix
    ./settings.nix
  ];

  config = mkIf dev.hasSound {
    # Enable PipeWire sound server and additional emulation layers
    # for all kinds of backwards compatibility. Audio on Linux has
    # always been finicky, and this is the best way to ensure that
    # we have the best compatibility with the most software.
    services.pipewire = {
      enable = true;

      # use PipeWire as the primary sound server
      audio.enable = true;

      # Additional emulation layers to enable on top of PipeWire.
      # The backward compatibility provided by below options are impeccable and therefore
      # I choose to keep them. On a minimal system, they can (and probably should)
      # be omitted
      pulse.enable = true; # PulseAudio server emulation
      jack.enable = true; # JACK audio emulation
      alsa = {
        enable = true; # ALSA support
        support32Bit = pkgs.stdenv.hostPlatform.isx86; # enable 32 bit also support on 64 bit system
      };
    };

    systemd.user.services = {
      pipewire.wantedBy = [ "default.target" ];
      pipewire-pulse.wantedBy = [ "default.target" ];
    };
  };
}
