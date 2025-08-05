{lib, ...}: let
  myConfig = import ./../../conf.nix;
in {
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
