#
# Thunar File manager
#
{ pkgs, ... }: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-media-tags-plugin
      thunar-volman # automatic management of removable drives and media
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      xfce.tumbler
      libgsf # odf files
      ffmpegthumbnailer
      kdePackages.ark # GUI archiver for thunar archive plugin
    ];
  };

  # thumbnail support on thunar
  services.tumbler.enable = true;
}
