{
  modules.device = {
    type = "laptop";
    cpu = {
      type = "amd";
      amd.pstate.enable = true;
      amd.zenpower.enable = true;
    };
    gpu.type = "hybrid-nv";
    monitors = ["eDP-1"];
    hasBluetooth = true;
    hasSound = true;
    hasTPM = true;
  };
}
