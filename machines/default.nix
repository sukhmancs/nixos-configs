{
  withSystem,
  inputs,
  ...
}: let
  inherit (inputs) self nixpkgs;
  inherit (inputs.self) lib; # I need mkService
  # inherit (lib) mkNixosIso mkNixosSystem mkModuleTree';
  # inherit (lib.lists) concatLists flatten singleton;

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

  isoRoles = [
    ../modules/roles/iso
    ../modules/roles/headless
  ];

  # Define a base configuration function
  baseSystemConfig = {
    hostname,
    roleModules,
    system ? "x86_64-linux",
    agenix,
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
    inherit system agenix;
  };

  # DESKTOP
  andromeda = baseSystemConfig {
    hostname = "andromeda";
    roleModules = workstationRoles;
    enableHome = true;
    inherit system agenix;
  };

  # SERVER
  triangulum = baseSystemConfig {
    hostname = "triangulum";
    roleModules = serverRoles;
    enableHome = true;
    inherit system agenix;
  };

  # ISO - Portable Workstation
  messier = mkNixosIso {
    hostname = "messier";
    system = "x86_64-linux";
    specialArgs = {
      inherit (self) keys;
      inherit lib modulesPath;
      inherit inputs self inputs' self';
    };
    modules =
      [
        ./${hostname}
        # (TODO: modules/shared also enables - apparmor, selinux, clamav, auditd, virtualization
        # so check the performance impact and disable accordingly)
        # ../modules/shared # modules shared across all hosts, enabled by default
        # ../modules/exclusive/nixos # modules shared across all hosts, but need to be enabled
      ]
      ++ isoRoles
      ++ [
        ../options
        # agenix
      ];
    # ++ homes; (TODO: maybe also add shared home modules to iso)
  };
}
