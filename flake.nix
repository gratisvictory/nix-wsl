{
  description = "NixOS-WSL @gratisvictory configuration";

  inputs = {
    nix-current-system.url = "github:nix-systems/current-system";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-24-11.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    nix-current-system,
    ...
  } @ inputs: let
    system = nix-current-system;
    username = "gratisvictory";
    hostname = "nixos";
    stateVersion = inputs.nixpkgs-unstable.lib.trivial.release;

    mkPkgs = nixpkgs: {
      inherit system;
      config.allowUnfree = true;
    };

    pkgsUnstable = import inputs.nixpkgs-unstable (mkPkgs inputs.nixpkgs-unstable);
    pkgsStable = import inputs.nixpkgs-stable (mkPkgs inputs.nixpkgs-stable);
    pkgs24-11 = import inputs.nixpkgs-24-11 (mkPkgs inputs.nixpkgs-24-11);

    mkOverlay = name: pkgs: final: prev: {${name} = pkgs;};
  in {
    nixosConfigurations.${hostname} = inputs.nixpkgs-unstable.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit username hostname stateVersion pkgsUnstable pkgsStable pkgs24-11;
        inherit inputs;
      };
      modules = [
        ({
          lib,
          config,
          ...
        }: {
          nixpkgs.overlays = [
            (mkOverlay "unstable" pkgsUnstable)
            (mkOverlay "stable" pkgsStable)
            (mkOverlay "24-11" pkgs24-11)
          ];

          imports = [
            inputs.nixos-wsl.nixosModules.wsl
            inputs.nix-ld.nixosModules.nix-ld
            {
              programs.nix-ld = {
                dev.enable = true;
                libraries = inputs.nix-ld.packages.${system}.default.libraries;
              };
            }
            ./wsl/nixos/default.nix

            inputs.home-manager.nixosModules.home-manager
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
