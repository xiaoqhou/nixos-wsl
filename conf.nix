{
  user = "devops";
  nixos-version = "25.11";
  install-fish = true; # used to demonstrate the config flag
  shell = {
    install = ["zsh" "fish"];
    default = "fish";
  };
  include-dev = false; # weather to include home/dev.nix
}
