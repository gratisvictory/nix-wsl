# {
#   ...
# }: {
#   home.packages = with pkgsUnstable; [
#     wslu
#     wsl-open
#     wsl-vpnkit
#     nix
#     direnv
#     nix-direnv
#     statix
#     deadnix
#     alejandra
#     helix
#     git
#     git-graph
#     delta
#     gh
#     nushell
#     starship
#     zig
#     check
#     pkg-config
#     gnumake
#     gcc
#     gdb
#     valgrind
#     lcov
#     clang-tools
#     subunit
#     gcovr
#     cppcheck
#     gtest
#     cmake
#     ncurses
#     bun
#     corepack_latest
#     typescript
#     eslint
#     esbuild
#     nodePackages.prettier
#     http-server
#     rustup
#     wasm-pack
#     fzf
#     fx
#     unzip
#     yazi
#     eza
#     jq
#     fd
#     fnm
#     curl
#     bat
#     htop
#     fastfetch
#     lazygit
#     lazydocker
#     onefetch
#     zoxide
#   ];
# }
{
  pkgsUnstable,
  pkgsStable,
  pkgs24-11,
  ...
}: {
  home.packages = with pkgsUnstable; [
    # --- WSL ---
    wslu
    wsl-open
    wsl-vpnkit

    # --- Nix Ecosystem ---
    nix
    direnv
    nix-direnv
    statix
    deadnix
    alejandra

    # --- Core Tools ---
    helix
    git
    git-graph
    delta
    gh
    claude-code

    # --- Shell ---
    nushell
    starship

    # --- Other Language Toolchains ---
    zig
    rustup
    wasm-pack
    fnm

    # --- Web Dev Tools ---
    bun
    corepack_latest
    typescript
    eslint
    esbuild
    nodePackages.prettier
    http-server

    # --- General CLI Utilities ---
    fzf
    fx
    unzip
    yazi
    eza
    jq
    fd
    curl
    bat
    htop
    fastfetch
    lazygit
    lazydocker
    onefetch
    zoxide
    xdg-utils
  ];
}
