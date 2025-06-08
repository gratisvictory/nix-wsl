{
  username,
  pkgsUnstable,
  flake-inputs,
  lib,
  ...
}: {
  nix = {
    settings = {
      trusted-users = [
        "root"
        username
      ];
      accept-flake-config = true;
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];

      warn-dirty = false;
      fallback = true;
      max-jobs = "auto";
      cores = 0;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    registry.nixpkgs.flake = flake-inputs.nixpkgs-unstable;

    package = pkgsUnstable.nixVersions.latest;

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      connect-timeout = 5
      log-lines = 25
      min-free = 128000000
    '';

    gc = lib.mkDefault {
      automatic = true;
      options = "--delete-older-than 7d";
      persistent = true;
      dates = "weekly";
    };

    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
  };
}
