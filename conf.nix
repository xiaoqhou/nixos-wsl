{
  user = "devops";
  nixosVersion = "25.11";
  shell = {
    # install shell, supported shells: zsh, fish
    install = ["zsh" "fish"];
    default = "zsh";
  };
  dev = {
    # weather to include home/dev.nix
    install = false;
  };
}
