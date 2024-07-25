{
  osConfig,
  lib,
  pkgs,
  ...
}: {
  config = {
    home.packages = with pkgs; [
      # CLI packages from nixpkgs
      catimg
      duf
      todo
      hyperfine
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
      nitch
      skim
      p7zip
      btop
    ];
  };
}
