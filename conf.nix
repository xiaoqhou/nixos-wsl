{
  user = "devops";
  nixos-version = "25.11";
  # install shell, supported shells: zsh, fish
  shell = {
    install = ["zsh" "fish"];
    default = "zsh";
  };
  # weather to include home/dev.nix
  include-dev = false;
}
