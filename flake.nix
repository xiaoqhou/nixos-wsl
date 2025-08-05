{
  description = "Local dev environment in nixos with wsl";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-wsl,
    home-manager,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    myConfig = import ./conf.nix; # custom values from conf.nix
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = {
          inherit myConfig;
        };
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.default
          ./wsl.nix
          ./home
          #{home-manager.users.${myConfig.user}.installFish = myConfig.install-fish;}
        ];
      };
    };

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };

  nixConfig = {
    # add access token for private repo used by nix inputs here, ie. access-token = [ gitlab.mycompany.com=PAT:<your token> ]
  };
}
