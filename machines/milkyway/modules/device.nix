{
  modules.device = {
    type = "laptop";
    cpu = {
      type = "amd";
      amd.pstate.enable = false;
      amd.zenpower.enable = false;
    };
    gpu.type = null; # "hybrid-nv";
    monitors = ["eDP-1"];
    hasBluetooth = true;
    hasSound = true;
    hasTPM = true;
  };
}
