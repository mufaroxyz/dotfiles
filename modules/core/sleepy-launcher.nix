{ pkgs, inputs, ... }: {
  imports = [ inputs.aagl.nixosModules.default ];

  programs.sleepy-launcher.enable = true;
}
