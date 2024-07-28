{
  osConfig,
  lib,
  pkgs,
  ...
}: {
  config = {
    home.packages = with pkgs; [
      # CLI packages from nixpkgs
      fzf
      file
      unzip
      ripgrep
      rsync
      fd
      jq
      figlet
      lm_sensors
      dconf
      p7zip
    ];
  };
}
