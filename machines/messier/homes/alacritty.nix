#
#  Terminal Emulator
#
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = {
          bold = {style = "Bold";};
          size = 14;
        };
        shell.program = "${pkgs.zsh}/bin/zsh";
      };
    };
  };
}
