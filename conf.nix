{
  user = "devops";
  nixos-version = "25.05";
  install-fish = true;
  shell = {
    install = ["zsh" "fish"];
    default = "zsh";
  };
}
