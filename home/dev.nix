{
  pkgs,
  user,
  ...
}: {
  # the following two lines fixed the vscode can't start in nixos-wsl issue
  # programs.nix-ld.enable = true;
  # programs.nix-ld.package = pkgs.nix-ld-rs;

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

  home.file = {
    ".terraformrc.template".text = ''
      credentials "gitlab.com" {
        token = "$GITLAB_TOKEN"
      }
    '';
    /*
    ".netrc.template".text = ''
      machine github.com
        login pat
        password $GITHUB_TOKEN
      '';
    */
  };
}
