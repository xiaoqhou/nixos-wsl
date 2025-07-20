{lib, config, ...}:
{
/*
  options.shell = lib.mkOption {
      type = lib.types.str;
      default = "bash";
      description = "Shell to use (e.g. bash, zsh, fish)";
    };
*/
    imports = [
      ./ohmyzsh.nix
    ];

}
