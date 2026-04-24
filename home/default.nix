{
  pkgs,
  lib,
  myConfig,
  ...
}: let
  installZsh = builtins.elem "zsh" myConfig.shell.install;
  installFish = builtins.elem "fish" myConfig.shell.install;
in {
  programs.zsh.enable = installZsh;
  programs.fish.enable = installFish;
  # programs.fish.enable = lib.mkIf (myConfig.shell.default == "fish") true;

  # default shell
  users.users.${myConfig.user}.shell = pkgs.${myConfig.shell.default};

  home-manager.extraSpecialArgs = {inherit myConfig;};
  home-manager.users.${myConfig.user} = ./home.nix;
}
