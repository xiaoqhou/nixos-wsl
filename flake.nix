{
  description = "Local dev environment in nixos with wsl";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-wsl,
    home-manager,
  }: let
    system = "x86_64-linux";
    user = "devops";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = {
          inherit user;
        };
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.default
          ./wsl.nix
          ./home-manager
        ];
      };
    };

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };

  nixConfig = {
    # add access token here, ie. access-token = [ gitlab.mycompany.com=PAT:<your token> ]
  };
}
