{pkgs, lib, ...}: {
  home.packages = with pkgs; [
    pre-commit
    kubectl
    kubectx
    go
    uv
    opencode
  ];

  programs.zsh = {
    initExtra = ''
        if [ -f ~/.gh_token ]; then
            export GH_TOKEN=$(cat ~/.gh_token)
        fi
    '';
  }

}