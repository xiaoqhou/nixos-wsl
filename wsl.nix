{
  pkgs,
  myConfig,
  ...
}: {
  system.stateVersion = myConfig.nixosVersion;
  wsl.enable = true;
  wsl.defaultUser = myConfig.user;

  time.timeZone = myConfig.timeZone;

  programs.nix-ld.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = with pkgs; [
    wslu # wsl utilities
    tree
    git
    curl
    wget
    bat
    jq
    zip
    unzip
    inetutils
    dig
    bottom
    gnupg
    ripgrep
    fd
    vim
    btop
    home-manager
    tmux
  ];

  environment.shellAliases = {
    l = "ls -lah";
    cat = "bat";
    nrs = "sudo nixos-rebuild switch --flake .";
    hm = "home-manager";
    hms = "home-manager switch --flake .";
    genpw = "gpg --gen-random --armor 1 10";
  };

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };

  users.users.${myConfig.user} = {
    isNormalUser = true;
    extraGroups = ["docker"];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # the way to import other nix files
  # imports = [./shell.nix];
  # home-manager.users.${myConfig.user} = import ./home.nix;
}
