{
  description = "Home Manager configuration of devops";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    myConfig = import ../my.conf;
    installFish = builtins.elem "fish" myConfig.shell.install;
  in {
    homeConfigurations.${myConfig.user} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home.nix
        ../overlays.nix
        {installFish = installFish;}
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments: myConfig -> home.nix, inputs -> overlays.nix
      extraSpecialArgs = {inherit myConfig inputs;};
    };
  };
}
