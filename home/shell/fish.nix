{
  pkgs,
  ...
}: {
  home.packages = [
  #  pkgs.oh-my-fish
    pkgs.starship
  ];

  programs.fish = {
    enable = true;
    functions = {
      show_path = "echo $PATH | tr ' ' '\n'";
      posix-source = ''
        for i in (cat $argv)
          set arr (echo $i |tr = \n)
          set -gx $arr[1] $arr[2]
        end
      '';
    };
    interactiveShellInit = ''
      # set theme to built-in theme Dracula
      fish_config theme choose Dracula
    '';
    # https://github.com/gazorby/awesome-fish
    plugins = [
      {
        name = "autopair";
        inherit (pkgs.fishPlugins.autopair) src;
      }
      {
        name = "sponge";
        inherit (pkgs.fishPlugins.sponge) src;
      }
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
      { 
        name = "foreign-env"; # run bash scripts
        src = pkgs.fishPlugins.foreign-env.src;
      }
      { 
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      /*
      {
        name = "pure"; # pure prompt
	src = pkgs.fishPlugins.pure.src;
      }
      {
        name = "gruvbox";  # gruvbox theme
	src = pkgs.fishPlugins.gruvbox.src;
      }
      */
      {
        # display tips about abbr/alias of command 
        # run __abbr_tips_init if it doesn't work
        name = "abbreviation-tips";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fish-abbreviation-tips";
          tag = "v0.7.0";
          sha256 = "sha256-F1t81VliD+v6WEWqj1c1ehFBXzqLyumx5vV46s/FZRU=";
        };
      }
    ];
  }; # programs.fish end

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

}
