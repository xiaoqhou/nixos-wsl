{
  pkgs,
  lib,
  user,
  stateVersion,
  ...
}: {
  home.stateVersion = "${stateVersion}";
  programs.home-manager.enable = true;

  home.username = user;
  home.homeDirectory = "/home/${user}";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    git-credential-manager
    wslu  # wsl utilities
    meslo-lgs-nf
    jetbrains-mono
    eza
    zellij
  ];

  home.shellAliases = {
    ls = "eza --icons=always";
    z = "zellij";
  };

  programs.git = {
    enable = true;
    userName = "xiaoqhou";
    userEmail = "houxq.bj@outlook.com";
    extraConfig = {
      # configuration for git-credential-manager
      credential.helper = "manager";
      credential.msauthFlow = "system";
      credential.credentialStore = "cache";
      credential.cacheOptions = "--timeout 60"; # in seconds
    };
  };

  programs.fzf.enable = true;

  programs.direnv.enable = true;

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };

  #imports = [./ohmyzsh.nix];
  imports = [./fish.nix];
}
