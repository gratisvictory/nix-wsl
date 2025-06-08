{
  pkgsUnstable,
  username,
  ...
}: {
  users = {
    defaultUserShell = pkgsUnstable.nushell;
    users.${username} = {
      isNormalUser = true;
      extraGroups = ["wheel" "docker"];
    };
  };
}
