{
  description = "NixOS-WSL @gratisvictory configuration";
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-24-11.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs-unstable,
    nixpkgs-stable,
    nixpkgs-24-11,
    home-manager,
    nixos-wsl,
    nix-ld,
    ...
  }: let
    system = "x86_64-linux";
    username = "gratisvictory";
    hostname = "nixos";
    stateVersion = nixpkgs-unstable.lib.trivial.release;

    # nixpkgs (unstable)
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    # nixpkgs (stable)
    pkgsStable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    # nixpkgs (24.11)
    pkgs24-11 = import nixpkgs-24-11 {
      inherit system;
      config.allowUnfree = true;
    };

    # overlay (unstable)
    overlay-unstable = final: prev: {
      unstable = pkgsUnstable;
    };

    # overlay (stable)
    overlay-stable = final: prev: {
      stable = pkgsStable;
    };

    # overlay (24.11)
    overlay-24-11 = final: prev: {
      "24-11" = pkgs24-11;
    };
  in {
    nixosConfigurations.${hostname} = nixpkgs-unstable.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit username hostname stateVersion pkgsUnstable pkgsStable pkgs24-11;
        flake-inputs = {
          inherit nixpkgs-unstable nixpkgs-stable nixpkgs-24-11 home-manager nixos-wsl nix-ld;
        };
      };
      modules = [
        ({
          flake-inputs,
          lib,
          config,
          ...
        }: {
          nixpkgs.overlays = [
            overlay-unstable
            overlay-stable
            overlay-24-11
          ];
          imports = [
            flake-inputs.nixos-wsl.nixosModules.wsl
            flake-inputs.nix-ld.nixosModules.nix-ld
            {
              programs.nix-ld.dev.enable = true;
              programs.nix-ld.libraries = flake-inputs.nix-ld.packages.${system}.default.libraries;
            }
            ./wsl/nixos/default.nix
            flake-inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit username stateVersion pkgsUnstable pkgsStable pkgs24-11;
                };
                users.${username} = {...}: {
                  imports = [./wsl/home-manager/home-wsl.nix];
                };
              };
            }
          ];
        })
      ];
    };
  };
}
