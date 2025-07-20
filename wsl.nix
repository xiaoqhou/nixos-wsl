{
  pkgs,
  conf,
  ...
}: {
  system.stateVersion = conf.nixos-version;
  wsl.enable = true;
  wsl.defaultUser = conf.user;

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
    neovim
    btop
    home-manager
  ];

  environment.shellAliases = {
    l = "ls -lah";
    cat = "bat";
    vim = "nvim";
    hm = "home-manager";
    genpw = "gpg --gen-random --armor 1 10";
  };

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };

  users.users.${conf.user} = {
    isNormalUser = true;
    extraGroups = ["docker"];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # the way to import other nix files
  # imports = [./shell.nix];
  # home-manager.users.${conf.user} = import ./home.nix;
}
