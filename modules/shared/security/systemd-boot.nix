{
  boot = {
    # Disable the editor in systemd-boot, the default bootloader for NixOS.
    # This prevents access to the root shell or otherwise weakening
    # security by tampering with boot parameters. If you use a different
    # boatloader, this does not provide anything. You may also want to
    # consider disabling similar functions in your choice of bootloader.
    loader.systemd-boot.editor = false;
  };
}