# nixos-wsl

NixOS setup for Windows Subsystem for Linux (WSL) using Nix flakes and Home Manager.

## Overview

This repository configures a NixOS environment specifically for WSL, using:

- `flake.nix` for the system-wide NixOS configuration
- `wsl.nix` for WSL-specific system settings
- `home/flake.nix` and `home/home.nix` for Home Manager user configuration
- `my.conf` for reusable local settings like username and NixOS version

The repo also includes a small `justfile` with helper tasks for rebuilding, formatting, and garbage collection.

## Repository structure

```
.
├── my.conf
├── flake.nix
├── justfile
├── LICENSE
├── README.md
├── wsl.nix
└── home
    ├── default.nix
    ├── env
    │   └── dev.nix
    ├── flake.nix
    ├── home.nix
    └── shell
        ├── default.nix
        ├── fish.nix
        └── zsh.nix
```

- `flake.nix`
  - Main flake entry point.
  - Defines NixOS configuration and imports `wsl.nix`, `home/flake.nix`, and the NixOS-WSL module.

- `my.conf`
  - Local configuration values such as `user`, `nixosVersion`, and shell settings.
  - Imported by both the root flake and Home Manager flake.

- `wsl.nix`
  - WSL-specific system configuration.
  - Enables WSL integration, default user, Docker rootless mode, Nix settings, and common packages.

- `home/`
  - `flake.nix`
    - Home Manager flake entry point for the user home configuration.
  - `home.nix`
    - Actual Home Manager module configuration used by `home/flake.nix`.
  - `default.nix`
    - Optional top-level configuration import for the home environment.
  - `env/`
    - Environment-specific package sets and configuration definitions.
  - `shell/`
    - Shell-specific configuration for `zsh` and `fish`.

- `justfile`
  - Task shortcuts for rebuilds, formatting, refresh, and garbage collection.

## How to rebuild NixOS

From the repository root, run either of these commands:

- `just build`
- `sudo nixos-rebuild switch --flake .`

This rebuilds the NixOS system configuration using the root flake and applies the changes immediately.

## How to refresh Home Manager

From the repository root, run either of these commands:

- `just refresh`
- `home-manager switch --flake home/`

This applies the Home Manager configuration defined in `home/flake.nix` and `home/home.nix`.

## Additional useful commands

- `just fmt`
  - Formats all `.nix` files in the repository using `nix fmt`.

- `just gc`
  - Runs `sudo nix-collect-garbage -d` to delete unused Nix generations and reclaim disk space.

## Notes

- The `wsl.nix` configuration enables `wsl.enable = true` and configures the default WSL user.
- The `home/flake.nix` flake uses `home-manager` and imports the home configuration from `home/home.nix`.
- Local settings in `conf.nix` can be customized for the username, shell choices, and NixOS version.
