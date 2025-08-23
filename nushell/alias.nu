alias fast = fastfetch
alias nixver = nixos-version
alias nixcollect = sudo nix-collect-garbage -d
alias flake = sudo nixos-rebuild switch --flake ~/nix
alias flakeup = nix flake update
alias flakereboot = sudo nixos-rebuild switch --flake ~/nix --reboot
alias pref = nix-prefetch-url
alias storedel = sudo nix-store --gc
alias open = wsl-open
alias dirallow = direnv allow
alias dirdeny = direnv deny
alias dirclean = rm -rf ~/.cache/nix-direnv .direnv
alias clangwslup = nix flake update ~/nix/flakes/clang
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
alias y = yarn
alias yb = yarn build
alias ycc = yarn cache clean
alias ya = yarn add
alias yi = yarn init
alias yf = yarn format
alias yff = yarn format:fix
alias yl = yarn lint
alias ylf = yarn lint:fix
alias yd = yarn dev
alias yrm = yarn remove
alias yrun = yarn run
alias yst = yarn start
alias ys = yarn serve
alias yt = yarn test
alias ytc = yarn test --coverage
alias yui = yarn upgrade-interactive
alias yup = yarn upgrade
alias yw = yarn workspace
alias yws = yarn workspaces
alias yad = yarn add -D
alias yap = yarn add -P
alias yii = yarn install --immutable
alias ydlx = yarn dlx
alias cb = cargo build
alias cr = cargo run
alias ca = cargo add
alias pc = pnpm clean
alias prv = pnpm preview
alias pb = pnpm build
alias pad = pnpm add -D
alias pi = pnpm install
alias pd = pnpm dev
alias pa = pnpm add
alias ps = pnpm start
alias pl = pnpm lint
alias plf = pnpm lint:fix
alias pf = pnpm format
alias pff = pnpm format:fix
alias pt = pnpm test
alias ptc = yarn test --coverage
alias pdlx = pnpm dlx
alias pexec = pnpm exec
alias pup = pnpm update
alias prm = pnpm remove
alias pg = pnpm generate
def clangwsl [] {
    echo "use flake ~/nix/flakes/clang" | save .envrc
    direnv allow
}
def nixfullupgrade [] {
    echo "🔄 Updating flake..."
    flakeup

    echo "🧹 Cleaning old generations..."
    nixcollect

    echo "🗑️ Cleaning Nix store..."
    storedel

    echo "🔁 Rebuilding and rebooting..."
    flakereboot
}
