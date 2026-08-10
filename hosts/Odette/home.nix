{ lib, pkgs, ... }:
let
  codex = pkgs.writeShellApplication {
    name = "codex";
    text = ''
      if ! OPENROUTER_API_KEY=$(/usr/bin/security find-generic-password -a "$USER" -s OPENROUTER_API_KEY -w); then
        echo "OPENROUTER_API_KEY is missing from macOS Keychain." >&2
        exit 1
      fi
      export OPENROUTER_API_KEY
      exec ${pkgs.codex}/bin/codex "$@"
    '';
  };

  codexConfigTemplate = pkgs.writeText "codex-config.toml" ''
    model_provider = "openrouter"
    model = "openai/gpt-5.6-sol"
    model_reasoning_effort = "high"

    [model_providers.openrouter]
    name = "OpenRouter"
    base_url = "https://openrouter.ai/api/v1"
    wire_api = "responses"
    env_key = "OPENROUTER_API_KEY"
  '';
in
{
  imports = [
    ../../modules/home/desktop-apps.nix
    ../../modules/home/opencode.nix
  ];

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = [
    codex
    pkgs.t3code
  ];

  # ponytail: Codex writes trusted-project settings to this file.
  home.activation.codexConfig = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    codexConfigPath="$HOME/.codex/config.toml"
    if [ -L "$codexConfigPath" ]; then
      run rm "$codexConfigPath"
    fi
    if [ ! -e "$codexConfigPath" ] || [ -L "$codexConfigPath" ]; then
      run mkdir -p "$HOME/.codex"
      run cp ${codexConfigTemplate} "$codexConfigPath"
      run chmod 600 "$codexConfigPath"
    fi
  '';

  xdg.configFile."opencode/opencode.json" = {
    target = "opencode/opencode.jsonc";
    force = true;
  };

  # ponytail: macOS 27 kills the Bun binary after Nix fixups; remove once nixpkgs re-signs it.
  programs.opencode.package = pkgs.opencode.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace packages/opencode/script/build.ts \
        --replace-fail \
        '    console.log(`Running smoke test: ''${binaryPath} --version`)' \
        '    if (process.platform === "darwin") await $`/usr/bin/codesign --force --sign - ''${binaryPath}`
          console.log(`Running smoke test: ''${binaryPath} --version`)'
    '';
    postFixup = (old.postFixup or "") + ''
      /usr/bin/codesign --force --sign - "$out/bin/.opencode-wrapped"
    '';
  });

  programs.opencode.settings = {
    plugin = lib.mkAfter [
      "file:///Users/mufaro/Documents/opencode-discord-activity/src/index.ts"
    ];
    mcp = {
      burp = {
        type = "remote";
        url = "http://127.0.0.1:9876";
        enabled = true;
      };
      figma-desktop = {
        type = "remote";
        url = "http://127.0.0.1:3845/mcp";
        enabled = true;
        timeout = 60000;
      };
    };
  };
}
