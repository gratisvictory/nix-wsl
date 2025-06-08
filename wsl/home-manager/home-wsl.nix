{
  stateVersion,
  username,
  ...
}: {
  imports = [
    ./home-packages-wsl.nix
    ./modules
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = stateVersion;
  };
}
