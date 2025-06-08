{...}: {
  programs = {
    nushell = {
      enable = true;
      configFile.source = ../../../nushell/config.nu;
      extraConfig = ''
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
      '';
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        add_newline = false;
        format = "$os$username$hostname$directory$git_branch$git_status$nix_shell$cmd_duration$status$character";

        character = {
          success_symbol = "[❯](green bold)";
          error_symbol = "[❯](red bold)";
          vimcmd_symbol = "[❮](green bold)";
        };

        os = {
          disabled = false;
          symbols = {
            NixOS = "❄️ ";
          };
        };

        username = {
          show_always = true;
          style_user = "bold purple";
          style_root = "bold red";
          format = "[$user]($style)";
        };

        hostname = {
          ssh_only = false;
          style = "bold purple";
          format = "[@$hostname]($style):";
        };

        directory = {
          truncation_length = 3;
          truncate_to_repo = true;
          style = "bold cyan";
          format = "[$path]($style)[$read_only]($read_only_style) ";
          read_only = "🔒";
          read_only_style = "red";
        };

        git_branch = {
          format = "[$symbol$branch]($style) ";
          symbol = "🌿 ";
          style = "bold green";
        };

        git_status = {
          format = "([$all_status$ahead_behind]($style) )";
          style = "bold yellow";
          ahead = "⇡$count ";
          behind = "⇣$count ";
          diverged = "⇕⇡$ahead_count⇣$behind_count ";
          modified = "!$count ";
          staged = "+$count ";
          renamed = "»$count ";
          deleted = "✘$count ";
        };

        nix_shell = {
          disabled = false;
          format = "[$symbol$state( \\($name\\))]($style) ";
          symbol = "❄️ ";
          style = "bold blue";
        };

        cmd_duration = {
          min_time = 5000;
          format = "[$duration]($style) ";
          style = "yellow";
        };

        status = {
          disabled = false;
          format = "[$symbol$status]($style) ";
          symbol = "✖";
          style = "bold red";
        };

        shlvl.disabled = true;
        line_break.disabled = true;
        time.disabled = true;
        shell.disabled = true;
      };
    };

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
