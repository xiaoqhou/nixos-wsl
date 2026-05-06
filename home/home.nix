{
  pkgs,
  config,
  lib,
  myConfig,
  ...
}: {
  home.stateVersion = myConfig.nixosVersion;
  programs.home-manager.enable = true;

  home.username = myConfig.user;
  home.homeDirectory = "/home/${myConfig.user}";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    meslo-lgs-nf
    jetbrains-mono
    lazygit
    git-credential-oauth
    eza
    devbox
    just
    gcc # used by nvim.treesitter
  ];

  home.shellAliases = {
    ls = "eza --icons=always";
    lgit = "lazygit";
    zrf = "zellij run -f --";
    fs = "rg .|fzf --print0"; # search from file, add -e for exact math
    vim = "nvim";
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "xiaoqhou";
      user.email = "houxq.bj@outlook.com";

      init.defaultBranch = "main";
      /*
      # git-credential-manager
      credential.helper = "manager";
      credential.credentialStore = "cache";
      credential.cacheOptions = "--timeout 36000"; # timout in seconds
      */
      # git-credential-oauth
      credential.helper = [
        "cache --timeout 36000" # 10 hours
        "oauth"
      ];
    };
  };

  programs.fzf.enable = true;

  programs.direnv = {
    enable = true;
    config = {
      global.hide_env_diff = true;
    };
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.zellij = {
    enable = false;
    settings = {
      simplified_ui = true;
      show_startup_tips = false;
      show_release_notes = false;
      theme = "catppuccin-frappe";
      ui.pane_frames = {
        hide_session_name = true;
        rounded_corners = true;
      };
      scrollback_editor = "vim";

      keybinds = {
        /*
         use _props to define attr of keybinds, i.e.
        _props = { clear-defaults = true; };
        */
        normal = {
          # alt+q to close pane
          "bind \"Alt q\"" = {CloseFocus = {};};
          /*
            use _args to define attrs of action, i.e.
          "bind \"Ctrl n\"" = { SwitchMode = { _args = [ "Normal" ]; } };
          */
        }; # end normal
      }; # end keybinds
    }; # end zellij.settings
  }; # end progams.zellij

  # clone https://github.com/xiaoqhou/dotfiles to local, i.e. ~/.dotfiles
  # link the neovim dotfiles, must use absolute path
  # xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/astronvim";

  imports =
    [
      ./shell
    ]
    ++ builtins.map (x: ./. + "/env/${x}.nix") (myConfig.envs or []);
}
