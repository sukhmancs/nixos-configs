{
  modules.device = {
    type = "laptop";
    cpu = {
      type = "amd";
    };
    gpu.type = "hybrid-nv"; # "null";
    monitors = ["eDP-1"];
    hasBluetooth = true;
    hasSound = true;
    hasTPM = false;
  };
}
