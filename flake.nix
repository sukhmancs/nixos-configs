{
  description = "Xi's NixOS configuration";

  inputs = {
    systems.url = "github:nix-systems/default-linux";

    # NixOS stable
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    # NixOS unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-unstable-small"; # moves faster, has less packages

    # Sometimes nixpkgs breaks something I need, pin a working commit when that occurs
    # nixpkgs-pinned.url = github:NixOS/nixpkgs/80657da2c1d4c35ba4331e85513223c7c2cdc485;

    # Flake parts for easier flake development
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake utilities
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    # NixOS hardware configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Nix hepler
    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    # Stylix - System-Wide theme configuration
    stylix.url = "github:danth/stylix";

    # Nix Formatter
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Deploy-rs - A deployment tool
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };

    # Documentation generation for module options
    ndg = {
      url = "github:feel-co/ndg";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs-small";
      };
    };

    # A tree-wide formatter
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    nixfmt = {
      url = "github:nixos/nixfmt";
      flake = false;
    };

    # Project shells
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    # git-hooks for nix
    git-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        flake-compat.follows = "flake-compat";
      };
    };

    # Sandbox wrappers for programs
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        flake-parts.follows = "flake-parts";
      };
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    # Gaming on NixOS
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Secure-boot support on nixos
    # Avoid on production systems for now
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };

    # nix-index database
    nix-index-db = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    atticd = {
      url = "github:zhaofengli/attic";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    # Secrets management
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        home-manager.follows = "home-manager";
        darwin.follows = "";
      };
    };

    # Rust overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
      };
    };

    # Nix Language server
    nil = {
      url = "github:oxalica/nil";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        rust-overlay.follows = "rust-overlay";
      };
    };

    # Nightly builds of Neovim
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
      };
    };

    # Notashelf' personal package collection for packages that are
    # not in nixpkgs.
    nyxpkgs.url = "github:NotAShelf/nyxpkgs";

    # NixVim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim configuration wrapper.
    neovim-flake = {
      url = "github:NotAShelf/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        nil.follows = "nil";
        flake-utils.follows = "flake-utils";
        flake-parts.follows = "flake-parts";
      };
    };

    # This will provide us with the latest version of the
    # vscode extensions.
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
      };
    };

    # Notashelf' wallpapers repository to provide various
    # wallpapers as nix packages.
    wallpkgs = {
      url = "github:NotAShelf/wallpkgs";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    # Anyrun program launcher
    anyrun.url = "github:anyrun-org/anyrun";
    anyrun-nixos-options = {
      url = "github:n3oney/anyrun-nixos-options";
      inputs = {
        flake-parts.follows = "flake-parts";
      };
    };

    # Aylur's gtk shell (ags)
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spicetify for theming spotify
    # spicetify = {
    #   url = "github:the-argus/spicetify-nix";
    #   inputs.nixpkgs.follows = "nixpkgs-small";
    # };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Post-modern configuration management
    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Schizophrenic Firefox configuration
    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs-small";
        flake-parts.follows = "flake-parts";
        nixpak.follows = "nixpak";
      };
    };

    # Mailserver on nixos
    simple-nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver/master";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    # Hyprland & Hyprland Contrib repos
    # to be able to use the binary cache, we should avoid
    # overriding the nixpkgs input - as the resulting hash would
    # mismatch if packages are built against different versions
    # of the same depended packages.
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    # Hyprland's wallpaper repository
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    # Hyprland's plugins repository
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      imports = [./flake-parts];

      flake = {
        nixosConfigurations = (
          import ./machines {
            inherit inputs withSystem;
          }
        );
      };
    });
}
