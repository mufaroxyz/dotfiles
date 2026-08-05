# Hosts

Create `hosts/<hostname>/default.nix` only when that machine's hostname and
platform are known. NixOS hosts also need their generated hardware
configuration; do not share it with another host.

`nixos` is the temporary exception: it wraps the archived desktop until that
machine can be rebuilt from a fresh generated hardware configuration.
