{lib, ...}: let
  myConfig = import ./../../conf.nix;
in {
  # there are two options to import/install shells
  # 1. import it and configure it using options, i.e fish 2. import it based on condition, i.e zsh
  imports =
    [
      ./fish.nix
    ]
    # import zsh optionally based on configuration
    # https://nixos-and-flakes.thiscute.world/other-usage-of-flakes/module-system
    ++ (lib.optionals (builtins.elem "zsh" myConfig.shell.install) [./zsh.nix]);

  # import fish directly but install it base on option
  installFish = myConfig.install-fish;
}
