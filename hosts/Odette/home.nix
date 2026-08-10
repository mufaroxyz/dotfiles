{ lib, pkgs, ... }:
let
  codex =
    (pkgs.writeShellApplication {
      name = "codex";
      text = ''
        if ! OPENROUTER_API_KEY=$(/usr/bin/security find-generic-password -a "$USER" -s OPENROUTER_API_KEY -w); then
          echo "OPENROUTER_API_KEY is missing from macOS Keychain." >&2
          exit 1
        fi
        export OPENROUTER_API_KEY
        exec ${pkgs.codex}/bin/codex "$@"
      '';
    }).overrideAttrs
      (_: {
        inherit (pkgs.codex) version;
      });
in
{
  imports = [
    ../../modules/home/desktop-apps.nix
    ../../modules/home/coding-agents.nix
  ];

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = [ pkgs.t3code ];

  programs.codex = {
    package = codex;
    settings.projects = {
      "/Users/mufaro".trust_level = "trusted";
      "/Users/mufaro/src/nix-config".trust_level = "trusted";
    };
  };

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

  programs.mcp.servers = {
    burp = {
      url = "http://127.0.0.1:9876";
      enabled = true;
    };
    figma-desktop = {
      url = "http://127.0.0.1:3845/mcp";
      enabled = true;
      tool_timeout_sec = 60;
    };
  };

  programs.opencode.settings = {
    plugin = lib.mkAfter [
      "file:///Users/mufaro/Documents/opencode-discord-activity/src/index.ts"
    ];
    mcp.figma-desktop = {
      type = "remote";
      url = "http://127.0.0.1:3845/mcp";
      enabled = true;
      timeout = 60000;
    };
  };
}
