{pkgs, lib, user, ...} :
{

   #programs.zsh.enable = true;
   programs.fish.enable = true;
   users.users.${user}.shell = pkgs.fish;
   home-manager.extraSpecialArgs = {
        inherit user;
	stateVersion = "25.05";
   };
   home-manager.users.${user} = ./home.nix;

}
