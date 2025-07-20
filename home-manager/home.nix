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
      credential.helper = [
     #   "${pkgs.git-credential-oauth}/bin/git-credential-oauth"
	"cache --timeout=21600"
      ];
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
