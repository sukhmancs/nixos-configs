{pkgs, ...}: {
  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        autotiling # Tiling Script
        # wev # Event Viewer
        # wl-clipboard # Clipboard
        # wlr-randr # Monitor settings
        # xwayland # X for Wayland
      ];
    };
  };
}
