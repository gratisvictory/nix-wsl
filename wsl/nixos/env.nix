{pkgsUnstable, ...}: {
  environment.enableAllTerminfo = true;
  environment.sessionVariables = rec {
    TERMINAL = "nushell";
    EDITOR = "code";
  };
}
