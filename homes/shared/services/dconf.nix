{
  dconf.settings = {
    # This will set the default color scheme to dark
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    # This will automatically add the virtualization connection to virt-manager
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
