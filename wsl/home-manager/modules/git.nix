{...}: {
  programs.git = {
    enable = true;
    userName = "gratisvictory";
    userEmail = "gratisvictory.dev@proton.me";

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

      aliases = {
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
        email = "gratisvictory.dev@proton.me"
      [core]
        sshCommand = "ssh github.com-gratisvictory"
      [commit]
        gpgSign = true
      [tag]
        gpgSign = true
    '';

    ".config/git/alexborzov.gitconfig".text = ''
      [user]
        name = "alexborzov"
        email = "alex.borzov@proton.me"
      [core]
        sshCommand = "ssh github.com-alexborzov"
      [commit]
        gpgSign = true
      [tag]
        gpgSign = true
    '';

    ".config/git/demonicattack.gitconfig".text = ''
      [user]
        name = "demonicattack"
        email = "demonicattack@proton.me"
      [core]
        sshCommand = "ssh github.com-demonicattack"
      [commit]
        gpgSign = true
      [tag]
        gpgSign = true
    '';

    ".gitignore".text = ''
      # IDE
      .idea/
      .vscode/
      *.sublime-*

      # OS
      .DS_Store
      Thumbs.db

      # Node
      node_modules/
      npm-debug.log

      # Python
      __pycache__/
      *.py[cod]
      .env
      .venv

      # Nix
      .envrc
      result
      .direnv
    '';
  };
}
