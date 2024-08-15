{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.virtualisation.libvirtd.enable {
    environment.systemPackages = with pkgs; [
      virt-manager # VM Interface
      virt-viewer # Remote VM
      qemu_kvm # Virtualizer
      qemu # Virtualizer
      OVMF # UEFI Firmware
      gvfs # Shared Directory
      swtpm # TPM
      virglrenderer # Virtual OpenGL
    ];

    virtualisation = {
      kvmgt.enable = true;
      spiceUSBRedirection.enable = true;

      libvirtd = {
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true; #FIXME:permission denied error everytime it is set to false. Manually changing file permissions did not work.
          swtpm.enable = true;

          ovmf = {
            enable = true;
            packages = [pkgs.OVMFFull.fd];
          };

          verbatimConfig = ''
            namespaces = []

            # Whether libvirt should dynamically change file ownership
            dynamic_ownership = 0
          '';
        };

        onBoot = "ignore";
        onShutdown = "shutdown";
      };
    };

    # this allows libvirt to use pulseaudio socket
    # which is useful for virt-manager
    hardware.pulseaudio.extraConfig = ''
      load-module module-native-protocol-unix auth-group=qemu-libvirtd socket=/tmp/pulse-socket
    '';

    # additional kernel modules that may be needed by libvirt
    boot.kernelModules = [
      "vfio-pci"
    ];

    # trust bridge network interface(s)
    networking.firewall.trustedInterfaces = ["virbr0" "br0"];
  };
}
