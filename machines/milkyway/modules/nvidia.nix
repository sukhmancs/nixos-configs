{lib, ...}: {
  config.hardware = {
    nvidia.prime = {
      amdgpuBusId = lib.mkDefault "PCI:5:0:0";
      nvidiaBusId = lib.mkDefault "PCI:1:0:0";
    };
  };
}
