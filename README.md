# Nix Configuration

One flake for this Mac, future NixOS machines, and a NixOS VPS. Dependency
versions are pinned in `flake.lock`.

## Layout

- `hosts/Odette/`: active Apple Silicon macOS configuration and its Home
  Manager user module.
- `hosts/nixos/`: temporary compatibility wrapper for the old x86_64 NixOS
  desktop, available as `nixosConfigurations.nixos`.
- `legacy/mufarodev-dotfiles/`: an unmodified 2024 Linux/Hyprland archive.
  Only the temporary `nixos` wrapper imports it.
- `AGENTS.md`: rules that keep active configuration independent of the archive.

## Current scope

`Odette` is declared as a nix-darwin host. It sets the macOS computer,
Bonjour, and Unix host names. Its fresh Home Manager module only establishes
the user identity and state version; no legacy package, shell, or desktop
configuration is active.

Applying a NixOS configuration requires a hostname, target platform, user
account, and its generated hardware configuration.

Add each real machine under `hosts/<hostname>/`. Keep shared configuration in
modules only after at least two hosts actually use it.

## Commands

```sh
nix flake check
nix fmt
nix flake update nixpkgs nix-darwin home-manager
```

On the existing desktop, evaluate the compatibility system before switching:

```sh
nixos-rebuild build --flake .#nixos
sudo nixos-rebuild switch --flake .#nixos
```

The Linux compatibility inputs are intentionally pinned to their October 2024
revisions. Do not include them in routine updates.

The next concrete additions are macOS packages or defaults and a VPS. The
desktop compatibility wrapper should be replaced rather than extended when
the NixOS desktop is rewritten.
