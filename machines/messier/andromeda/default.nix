{
  pkgs,
  inputs,
  cfg,
  ...
}: [
  # (inputs.wrapper-manager.lib.build {
  #   inherit pkgs;
  #   modules = [
  #     {
  #       wrappers = {
  #         foot = import ./configs/foot {inherit inputs pkgs cfg;};

  #         # gtklock = import ./configs/gtklock {inherit pkgs;};
  #         # mako = import ./configs/mako {inherit pkgs cfg;};
  #         # rofi = import ./configs/rofi {inherit pkgs cfg;};
  #         # swayidle = import ./configs/swayidle {inherit pkgs;};
  #       };
  #     }
  #   ];
  # })
  (import ./configs/river {inherit pkgs cfg;})
]
