{
  lib,
  config,
  ...
}: {
  virtualisation.docker = {
    enable = lib.mkIf (!config.wsl.docker-desktop.enable) true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };
}
