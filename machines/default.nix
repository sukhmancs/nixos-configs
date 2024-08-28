{
  withSystem,
  inputs,
  ...
}: let
  inherit (inputs) self nixpkgs;
  inherit (inputs.self) lib; # I need mkService
  inherit (lib) mkNixosIso;

  # Inputs
  hw = inputs.nixos-hardware.nixosModules; # hardware compat for pi4 and other quirky devices
  agenix = inputs.agenix.nixosModules.default; # secret encryption via age
  hm = inputs.home-manager.nixosModules.home-manager; # home-manager nixos module

  # Home-manager
  homesPath = ./home.nix;
  homes = [hm homesPath];

  # Default
  system = "x86_64-linux";
  modulesPath = "${nixpkgs}/nixos/modules";

  # Define role-specific module lists
  workstationRoles = [
    ../modules/roles/workstation
    ../modules/roles/graphical
  ];

  laptopRoles = [
    ../modules/roles/laptop
    ../modules/roles/workstation
    ../modules/roles/graphical
  ];

  serverRoles = [
    ../modules/roles/server
    ../modules/roles/headless
  ];

  isoRolesHeadless = [
    ../modules/roles/iso
    ../modules/roles/headless
  ];

  # Define a base configuration function
  baseSystemConfig = {
    hostname,
    roleModules,
    system ? "x86_64-linux",
    agenix ? null,
    enableHome ? true,
  }:
    withSystem system ({
      inputs',
      self',
      ...
    }:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          [
            {networking.hostName = hostname;}
            ./${hostname}
            ../modules/shared # modules shared across all hosts, enabled by default
            ../modules/exclusive/nixos # modules shared across all hosts, but need to be enabled
          ]
          ++ roleModules
          ++ [
            ../options
            agenix
          ]
          ++ (
            if enableHome
            then homes
            else []
          );
        specialArgs = {
          inherit (self) keys;
          inherit lib modulesPath;
          inherit inputs self inputs' self';
        };
      });
in {
  # LAPTOP
  # ASUS TUF FX505D laptop from 2019
  # equipped with Ryzen 7 7730U
  milkyway = baseSystemConfig {
    hostname = "milkyway";
    roleModules = laptopRoles;
    enableHome = true;
    inherit system agenix; # Todo - do not need secrets
  };

  # DESKTOP
  andromeda = baseSystemConfig {
    hostname = "andromeda";
    roleModules = workstationRoles;
    enableHome = true;
    inherit system agenix; # Todo - do not need secrets
  };

  # SERVER
  triangulum = baseSystemConfig {
    hostname = "triangulum";
    roleModules = serverRoles;
    enableHome = false; #TODO: enable home-manager for server
    inherit system agenix;
  };

  # Graphical ISO - Portable Workstation
  messier = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit lib inputs self;
    };
    modules =
      [
        {networking.hostName = "messier";}
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-base.nix"

        # bootstrap channels with the ISO image to avoid fetching them during installation
        "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"

        # make sure our installer can detect and interact with all hardware that is supported in Nixpkgs
        # this loads basically every hardware related kernel module
        "${nixpkgs}/nixos/modules/profiles/all-hardware.nix"

        ./messier
        ../modules/roles/iso
      ]
      ++ [
        hm
        ./messier/home.nix
      ];
  };
}
