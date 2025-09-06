{...}: {
  programs.git = {
    enable = true;
    userName = "gratisvictory";
    userEmail = "gratisvictory@gmail.com";

    delta = {
      enable = true;
      options = {
        features = "decorations";
        line-numbers = true;
        side-by-side = true;
        navigate = true;
        light = false;
        syntax-theme = "Dracula";
        plus-style = "syntax #003800";
        minus-style = "syntax #3f0001";
      };
    };

    extraConfig = {
      core = {
        editor = "code --wait";
        autocrlf = "input";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        excludesfile = "~/.gitignore";
      };

      init.defaultBranch = "main";

      pull = {
        rebase = true;
        ff = "only";
      };

      push = {
        default = "current";
        autoSetupRemote = true;
        followTags = true;
      };

      merge = {
        conflictstyle = "diff3";
        tool = "vscode";
        log = true;
      };

      mergetool.vscode = {
        cmd = "code --wait $MERGED";
        trustExitCode = true;
      };

      diff = {
        colorMoved = "default";
        algorithm = "histogram";
        tool = "vscode";
      };

      difftool.vscode = {
        cmd = "code --wait --diff $LOCAL $REMOTE";
      };

      color = {
        ui = "auto";
        branch = {
          current = "yellow bold";
          local = "green bold";
          remote = "red bold";
        };
        diff = {
          meta = "yellow bold";
          frag = "magenta bold";
          old = "red bold";
          new = "green bold";
        };
        status = {
          added = "green bold";
          changed = "yellow bold";
          untracked = "red bold";
        };
      };

      alias = {
        whoami = "! git config user.name && git config user.email && git config core.sshCommand";
        st = "status -sb";
        last = "log -1 HEAD --stat";
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";

        br = "branch";
        ba = "branch -a";
        bd = "branch -d";
        bD = "branch -D";

        cm = "commit -m";
        ca = "commit --amend";
        can = "commit --amend --no-edit";

        unstage = "reset HEAD --";
        undo = "reset --soft HEAD^";

        ss = "stash save";
        sp = "stash pop";
        sl = "stash list";

        cleanup = "!git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d && git remote prune origin";
      };
    };
  };

  home.file = {
    ".config/git/gratisvictory.gitconfig".text = ''
      [user]
        name = "gratisvictory"
        email = "gratisvictory@gmail.com"
      [core]
        sshCommand = "ssh github.com-gratisvictory"
      [commit]
        gpgSign = true
      [tag]
        gpgSign = true
    '';

    ".gitignore".text = ''
            # --- Build Outputs ---
      /.next/
      /out/
      /build
      /dist
      /dist-ssr
      /tmp
      /out-tsc
      *.bundle.js
      *.chunk.js
      *.min.js
      *.min.css

      # --- Dependencies ---
      /node_modules
      /.pnp
      .pnp.*
      .yarn/*
      !.yarn/patches
      !.yarn/plugins
      !.yarn/releases
      !.yarn/versions

      # --- Environment Variables ---
      .env*
      .env*.local
      !.env.example
      *.local

      # --- Package Manager Files ---
      npm-debug.log*
      yarn-debug.log*
      yarn-error.log*
      pnpm-debug.log*
      lerna-debug.log*
      package-lock.json
      yarn.lock
      bun.lock
      pnpm-lock.yaml

      # --- TypeScript ---
      *.tsbuildinfo
      next-env.d.ts
      vite-env.d.ts
      react-env.d.ts
      **/routeTree.gen.ts
      .tanstack
      .firebase
      telegram-api.ts
      # --- Testing and Coverage ---
      /coverage
      .nyc_output/
      /libpeerconnection.log
      testem.log

      # --- IDE and Editors ---
      # VSCode
      .vscode/*
      !.vscode/settings.json
      !.vscode/tasks.json
      !.vscode/launch.json
      !.vscode/extensions.json

      # JetBrains IDEs
      .idea/
      *.iml
      *.ipr
      *.iws

      # Other editors
      .project
      .classpath
      .c9/
      *.launch
      .settings/
      *.sublime-workspace
      *.suo
      *.ntvs*
      *.njsproj
      *.sln
      *.sw?

      # --- Nx Specific ---
      .nx/cache
      .nx/workspace-data
      .cursor/rules/nx-rules.mdc
      .github/instructions/nx.instructions.md

      # --- Temporary Files ---
      *.tmp
      *.temp
      .cache/
      /.sass-cache
      /connect.lock
      /typings
      logs
      *.log

      # --- System Files ---
      .DS_Store
      Thumbs.db
      *.pem

      # --- Deployment ---
      .vercel
      .netlify

      # --- Sensitive Data ---
      *config.private.*
      *credentials.*
      *secret.*
      *token.*
      *key.*

      # --- Backup Files ---
      *.bak
      *.backup
      *~

      # --- Generated files ---
      .generated/
      generated/

      # --- Database files ---
      *.sqlite
      *.sqlite3
      *.db

      # --- Debug files ---
      .debug/

      # --- Certificates files ---
      certificates
    '';
  };
}
