#
# devShell - a shell for Nix project. It includes tools for development and
# debugging, such as formatters, linters, and source control tools. This shell
# is intended to be used in conjunction with direnv, which will automatically
# load the shell environment when you enter the project directory.
#
# To manually use this development environment, ensure you have Nix installed and run
# `nix run '.#<myapp>' -- <devshell-command> <and-args>`.  This makes it possible to run
# commands defined in your devshell without entering a nix-shell or nix develop session.
#
{
  perSystem = {
    inputs',
    config,
    pkgs,
    ...
  }: let
    env = import ./env.nix;
    packages = import ./packages.nix {inherit pkgs inputs' config;};
    commands = import ./commands.nix;
  in {
    devShells.default = inputs'.devshell.legacyPackages.mkShell {
      name = "nixos-dotfiles";
      commands = commands;
      env = env;
      # packages to include in the shell
      # inputsFrom = [config.treefmt.build.devShell];
      packages = packages;
    };
  };
}
