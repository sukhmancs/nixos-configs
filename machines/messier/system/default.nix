{
  config,
  pkgs,
  inputs,
  ...
}: {
  # config = {
  #   environment.systemPackages =
  #     import ./wrapper {inherit pkgs inputs config;};
  # };
  imports = [
    ./programs
    # ./boot.nix
    ./users.nix
    ./console.nix
  ];
}
