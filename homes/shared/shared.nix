{
  osConfig,
  lib,
  pkgs,
  inputs',
  ...
}: {
  config = {
    home.packages = with pkgs; [
      # packages from inputs
      (inputs'.agenix.packages.default.override {ageBin = "${pkgs.rage}/bin/rage";})
      inputs'.nyxpkgs.packages.cloneit

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
