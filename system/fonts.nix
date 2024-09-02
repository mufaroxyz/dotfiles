{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    material-design-icons
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
    corefonts
    font-awesome
    twemoji-color-font
    noto-fonts
    noto-fonts-emoji
    cascadia-code
    iosevka
  ];
}
