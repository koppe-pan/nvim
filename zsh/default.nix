{ config, pkgs,... }:
{
  home.file.".p10k.zsh".text = builtins.readFile ./p10k.zsh;
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    completionInit = ''
      autoload -U compinit && compinit -u
    '';
    sessionVariables = {
      ZSH_DISABLE_COMPFIX = "true";
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "viins";

    # .zshenvに環境変数を設定（zsh起動前に読み込まれる）
    envExtra = ''
      export ZSH_DISABLE_COMPFIX=true
    '';

    initContent = ''
      # Force compinit with -u flag for NixOS
      autoload -U compinit && compinit -u
      
      FPATH=${./zsh/functions}:$FPATH

      export FPATH

      . ${./zsh/functions.zsh}

      bindkey "''${key[Up]}" up-line-or-search 
      bindkey "''${key[Down]}" down-line-or-search 
      source ~/.p10k.zsh
    '';

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = ["git" "tmux" "docker"];
    };


    plugins = [   
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    shellAliases = {
      cp = "cp -i";
      grep = "grep --colour=auto";
      mv = "mv -i";
      vim = "nvim";

      du = "${pkgs.ncdu}/bin/ncdu --color dark -rr -x";
      ll = "${pkgs.eza}/bin/eza";
      ping = "${pkgs.prettyping}/bin/prettyping";
      tree = "${pkgs.eza}/bin/eza -T";
      xdg-open = "${pkgs.mimeo}/bin/mimeo";
    };
  };
}
