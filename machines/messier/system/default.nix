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
    ./nixpkgs.nix
    # ./boot.nix
    ./users.nix
    ./console.nix
  ];
}
