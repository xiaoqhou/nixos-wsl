{
  pkgs,
  lib,
  conf,
  ...
}: {
  programs.zsh.enable = true;
  programs.fish.enable = lib.mkIf (conf.shell == "fish") true;
  users.users.${conf.user}.shell = 
    if conf.shell == "zsh" then pkgs.zsh
    else if conf.shell == "fish" then pkgs.fish
    else pkgs.bash;

  home-manager.extraSpecialArgs = {
    user = "${conf.user}";
    stateVersion = "${conf.nixos-version}";
  };
  home-manager.users.${conf.user} = ./home.nix;
}
