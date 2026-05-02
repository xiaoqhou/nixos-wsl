{pkgs, config, ...}: {
  home.packages = with pkgs; [
    pre-commit
    kubectl
    kubectx
    go
    gh
    opencode
    # dependencies of hermes agent
    uv
    ffmpeg
    playwright
#    nodejs_24
    python311
    python3Packages.pip
  ];

  programs.bash = {
    # enable = true;
    bashrcExtra = ''
        if [ -f ~/.gh_token ]; then
            export GH_TOKEN=$(cat ~/.gh_token) #used by gh and hermes
        fi
    '';
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  #  link the driver d
  home.file = {
    # ".hermes" = {
    #   source = config.lib.file.mkOutOfStoreSymlink "/mnt/d/agent/hermes";
    #   recursive = true; 
    # };
    "workspace" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/d/agent/workspace";
      recursive = true; 
    };
  };

}
