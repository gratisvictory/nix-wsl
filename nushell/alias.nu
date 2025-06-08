alias fast = fastfetch
alias nixver = nixos-version
alias nixcollect = sudo nix-collect-garbage -d
alias flake = sudo nixos-rebuild switch --flake ~/nix-wsl
alias flakeup = nix flake update
alias flakereboot = sudo nixos-rebuild switch --flake ~/nix-wsl --reboot
alias pref = nix-prefetch-url
alias storedel = sudo nix-store --gc
alias open = wsl-open
alias one = onefetch
alias graph = git-graph
alias lgit = lazygit
alias ldocker = lazydocker
alias ls = eza
alias ll = eza -l
alias la = eza -la
alias lt = eza --tree
alias lg = eza --git-ignore
alias lm = eza --sort=modified
alias lz = eza --sort=size
alias ld = eza --only-dirs
alias lf = eza --only-files
alias lla = eza -la --group-directories-first
alias llt = eza -l --tree
alias llg = eza -l --git
alias y = yazi
alias cat = bat
alias bathelp = bat --plain --language=help
alias batj = bat --language=json
alias baty = bat --language=yaml
alias batx = bat --language=xml
alias batm = bat --style=plain --language=markdown
alias batdiff = git diff --name-only --diff-filter=d | xargs bat --diff
alias batman = bat -l man -p
def nixfullupgrade [] {
    echo "🔄 Updating flake..."
    if (do { flakeup } | complete).exit_code != 0 { return 1 }

    echo "🧹 Cleaning old generations..."
    if (do { nixcollect } | complete).exit_code != 0 { return 1 }

    echo "🗑️ Cleaning Nix store..."
    if (do { storedel } | complete).exit_code != 0 { return 1 }

    echo "🔁 Rebuilding and rebooting..."
    flakereboot
}
