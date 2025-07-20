{
  pkgs,
  lib,
  user,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k.src;
        file = "powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-fzf-tab";
        src = pkgs.zsh-fzf-tab.src;
        file = "fzf-tab.plugin.zsh";
      }
    ];
    initContent = lib.mkMerge [
      # early initialization to replace initExtraFirst scripts
      (lib.mkBefore
        ''
          # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
          if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
            source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
          fi
        '')
      # modify the termianl title(zellij frame title)
      (lib.mkAfter ''
        function terminal_title_precmd() {
        	print -Pn -- '\e]0; %~\a'
        }
        add-zsh-hook -Uz precmd terminal_title_precmd
      '')

      ''
        # Powerlevel10k Zsh theme, run `p10k configure` to customize prompt.
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        # Additional history options
        setopt hist_ignore_all_dups
        setopt hist_save_no_dups
        setopt hist_find_no_dups

        # Completion styling
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --icons $realpath'
        zstyle ':fzf-tab:*' switch-group '<' '>'
      ''
    ];

    oh-my-zsh = {
      enable = true;
      plugins = ["sudo" "copybuffer" "eza" "aliases" "command-not-found" "copypath"]; # vi-mode
    };
  }; # programs.zsh end
}
