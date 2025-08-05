{
  pkgs,
  lib,
  myConfig,
  ...
}: {
  programs.zsh.enable = builtins.elem "zsh" myConfig.shell.install;
  # programs.fish.enable = lib.mkIf (myConfig.shell.default == "fish") true;
  programs.fish.enable = builtins.elem "fish" myConfig.shell.install;
  users.users.${myConfig.user}.shell = pkgs.${myConfig.shell.default}; # default shell

  home-manager.extraSpecialArgs = {
    user = "${myConfig.user}";
    stateVersion = "${myConfig.nixos-version}";
  };
  home-manager.users.${myConfig.user} = ./home.nix;
}
