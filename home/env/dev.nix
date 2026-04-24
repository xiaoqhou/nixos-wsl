{pkgs, lib, ...}: {
  home.packages = with pkgs; [
    tenv
    awscli2
    pre-commit
    kubectl
    kubectx
    go
    uv
  ];

  programs.zsh = {
    oh-my-zsh = {
      plugins = ["docker" "terraform" "aws" "kubectl" "kubectx"];
    };
  };

  /*
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        User xiaoqhou
        StrictHostKeyChecking no
    '';
  };
  */

  /*
  home.file = {
    ".terraformrc.template".text = ''
      credentials "gitlab.com" {
        token = "_GITLAB_TOKEN_"
      }
    '';
    ".netrc.template".text = ''
      machine github.com
        login pat
        password _GITHUB_TOKEN_
      '';
  };
  */
}
