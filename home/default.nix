{
  pkgs,
  lib,
  config,
  myConfig,
  ...
}: {
  programs.zsh.enable = true;
  # programs.fish.enable = lib.mkIf (myConfig.shell == "fish") true;
  programs.fish.enable = myConfig.install-fish;
  users.users.${myConfig.user}.shell = pkgs.zsh; # default shell, can be fish if it enabled

  home-manager.extraSpecialArgs = {
    user = "${myConfig.user}";
    stateVersion = "${myConfig.nixos-version}";
  };
  home-manager.users.${myConfig.user} = ./home.nix;
}
