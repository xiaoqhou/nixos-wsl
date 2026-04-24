default:
  @just --list

build: fmt
  sudo nixos-rebuild switch --flake .

fmt:
  nix fmt *.nix
  nix fmt **/*.nix

gc:
  sudo nix-collect-garbage -d
