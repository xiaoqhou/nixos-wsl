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
    lazygit
    git-credential-oauth
    eza
    vscode
  ];

  home.shellAliases = {
    ls = "eza --icons=always";
    lgit = "lazygit";
    z = "zellij";
    fs = "rg .|fzf --print0"; # search from file, add -e for exact math
  };

  programs.git = {
    enable = true;
    userName = "xiaoqhou";
    userEmail = "houxq.bj@outlook.com";
    extraConfig = {
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

  programs.direnv.enable = true;

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.zellij = {
    enable = true;
    settings = {
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

  imports = [
    ./shell
  ];
}
