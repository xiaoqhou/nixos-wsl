{
  pkgs,
  conf,
  ...
}: {
  programs.zsh.enable = true;
  #programs.fish.enable = true;
  users.users.${conf.user}.shell = pkgs.zsh;
  home-manager.extraSpecialArgs = {
    user = "${conf.user}";
    stateVersion = "${conf.nixos-version}";
  };
  home-manager.users.${conf.user} = ./home.nix;
}
