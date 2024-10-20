{
  modules.device = {
    type = "laptop";
    cpu = {
      type = "amd";
    };
    gpu.type = null; # "hybrid-nv";
    monitors = [ "eDP-1" ];
    hasBluetooth = true;
    hasSound = true;
    hasTPM = false;
  };
}
