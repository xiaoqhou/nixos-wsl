{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs;
    [
      pre-commit
      kubectl
      kubectx
      go
      gh
      opencode
      # dependencies of hermes agent
      uv
      ffmpeg
      playwright # required by agent-browser
      chromium # required by agent-browser
      # nodejs_24
      (python311.withPackages (ps:
        with ps; [
          pip
          # the following are used by llm-wiki skill
          pypdf
          python-docx
        ]))
      binutils # include strings
    ]
    ++ (with pkgs.unstable; [
      agent-browser
    ]);

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

  home.shellAliases = {
    her = "hermes";
    herui = "~/hermes-webui/start.sh";
  };

  #  link the driver d
  home.file = {
    "hermes-webui" = {
      source = builtins.fetchGit {
        url = "https://github.com/nesquena/hermes-webui";
        rev = "219f5d6ce5f04eb4121b3893decb92ab79e48337"; #v0.50.253
      };
      recursive = true;
    };
    "workspace" = {
      source = config.lib.file.mkOutOfStoreSymlink "/mnt/d/agent/workspace";
      recursive = true;
    };
  };
}
