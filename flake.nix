{
  description = "Local dev environment in nixos with wsl";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-wsl,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    myConfig = import ./my.conf; # custom values from my.conf
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = {
          inherit myConfig inputs;
        };
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.default
          ./wsl.nix
          ## run home config using alias hms in home directory
          ./home
          ./overlays.nix
          ## use the following to clean home config
          # {home-manager.users.${myConfig.user} = {
          #   home.stateVersion = myConfig.nixosVersion;
          # };}
        ];
      };
    };

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };

  nixConfig = {
    # add access token for private repo used by nix inputs here, ie. access-token = [ gitlab.mycompany.com=PAT:<your token> ]
  };
}
