{
  username,
  hostname,
  stateVersion,
  ...
}: {
  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  wsl = {
    enable = true;
    defaultUser = username;
    startMenuLaunchers = true;
    docker-desktop.enable = true;

    wslConf = {
      interop = {
        enable = true;
        appendWindowsPath = false;
      };
      automount = {
        enabled = true;
        root = "/mnt";
        options = "metadata,umask=22,fmask=11";
        mountFsTab = true;
      };
      network.generateHosts = false;
      shutdown.enabled = true;
    };
  };
}
