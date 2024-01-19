{
  inputs,
  username,
  ...
}: {
  imports =
    # [(import ./waybar)]
    # ++ [(import ./firefox)]
    # ++ [(import ./vscode)]
    # ++ [(import ./hyprland)]
    # ++ [(import ./gaming)]
    # ++ [(import ./git)]
    # ++ [(import ./btop)]
    # ++ [(import ./bat)]
    # ++ [(import ./cava)]
    # ++ [(import ./kitty)]
    # ++ [(import ./micro)] # nano replacement
    # ++ [(import ./audacious)] # music player
    # ++ [(import ./discord-canary)] # discord with catppuccin theme
    # ++ [(import ./swaylock)]
    # ++ [(import ./wofi)]
    # ++ [(import ./zsh)]
    # ++ [(import ./gtk)]
    # ++ [(import ./mako)] # notification deamon
    # ++ [(import ./scripts)] # personal scripts
    # ++ [(import ./starship)]
    # ++ [(import ./nvim)]
    # ++ [(import ./package)];
    [(import ./apps)]
    ++ [(import ./cli)]
    ++ [(import ./cli-apps)]
    ++ [(import ./desktop)]
    ++ [(import ./package)]
    ++ [(import ./tools)];
}
