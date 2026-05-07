# nixos-wsl

NixOS setup for Windows Subsystem for Linux (WSL) using Nix flakes and Home Manager.
The nixos-wsl configuration and home user configuration can be built separately.

## Hermes Agent Support

This repository supports setting up a development environment for [Hermes Agent](https://github.com/nousresearch/hermes-agent), an AI-powered coding assistant. The `home/env/hermes-agent.nix` module provides all necessary packages and configurations for running Hermes Agent in your WSL environment.

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
├── overlays.nix
├── README.md
├── wsl.nix
└── home
    ├── default.nix
    ├── env
    │   ├── dev.nix
    │   └── hermes-agent.nix
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

- `overlays.nix`
  - Defines Nixpkgs overlays to add packages from unstable channels.

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
    - `dev.nix`: Development tools and configurations.
    - `hermes-agent.nix`: Packages for Hermes agent setup.
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

## Hermes Agent Environment Setup

To set up the Hermes Agent environment:

1. **Modify `my.conf`** to enable the hermes-agent environment:
   ```nix
   {
     ...
     envs = ["hermes-agent"];
     ...
   }
   ```

2. **Apply the Home Manager configuration**:
   - Run `just refresh` or `home-manager switch --flake home/`
This will install all necessary packages for Hermes Agent, including Python dependencies, Node.js, Chromium, and other required tools.

3. **Install Hermes agent**:
   - Run `curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash`
Check installation guide from https://github.com/nousresearch/hermes-agent.

## Notes

- The `wsl.nix` configuration enables `wsl.enable = true` and configures the default WSL user.
- The `home/flake.nix` flake uses `home-manager` and imports the home configuration from `home/home.nix`.
- Local settings in `my.conf` can be customized for the username, shell choices, and NixOS version.
