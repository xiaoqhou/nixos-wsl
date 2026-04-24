{
  user = "devops";
  nixosVersion = "25.11";
  shell = {
    # install shell, supported shells: zsh, fish
    install = ["zsh" "fish"];
    default = "zsh";
  };
  # intall nix from home/env/<env>.nix file, e.g. "dev"
  # envs = ["dev"];
}
