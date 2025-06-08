{...}: {
  imports = [
    ./boot.nix
    ./docker.nix
    ./env.nix
    ./home-manager.nix
    ./nix.nix
    ./security.nix
    ./services.nix
    ./system.nix
    ./time.nix
    ./user.nix
    ./wsl.nix
  ];
}
