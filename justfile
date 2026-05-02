# list tasks
default:
  @just --list

# rebuild nixos
build: fmt
  sudo nixos-rebuild switch --flake .

fmt:
  nix fmt *.nix
  nix fmt **/*.nix

# refesh home-manager packages
refresh:
  home-manager switch --flake home/

# collect nix garbage
gc:
  sudo nix-collect-garbage -d

repair:
  sudo nix-store --verify --check-contents --repair
