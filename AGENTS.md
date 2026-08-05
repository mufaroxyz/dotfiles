# Active Configuration Rules

- Treat `flake.nix` and `hosts/` as the only active configuration.
- Use current official Nix, nix-darwin, and Home Manager documentation when
  changing active configuration.
- Keep host-specific settings in that host's directory. Create shared modules
  only after a second active host needs the same configuration.
- Validate active changes with `nix flake check --all-systems` and `nix fmt`.
- `hosts/nixos/default.nix` is a temporary compatibility boundary and is the
  only active file allowed to import the legacy snapshot.
- Do not upgrade compatibility-only Linux inputs or extend the wrapper. Replace
  it with fresh modules when work resumes on the desktop.

# Legacy Archive Rules

- `legacy/mufarodev-dotfiles/` is an archival snapshot, not a template or code
  reference. Do not add imports outside the existing compatibility boundary.
- Never format, edit, copy, or cite legacy files as examples when writing new
  active configuration.
- When recreating a legacy feature, implement it freshly from the requested
  behavior and current upstream documentation.
- Preserve the archive unchanged unless the user explicitly asks to alter it.
