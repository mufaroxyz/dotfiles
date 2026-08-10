{ lib, pkgs, ... }:
{
  imports = [
    ../../modules/home/desktop-apps.nix
    ../../modules/home/opencode.nix
  ];

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    discord
  ];

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
