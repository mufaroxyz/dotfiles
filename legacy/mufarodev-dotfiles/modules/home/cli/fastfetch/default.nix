{ pkgs, ... }: {
  programs.fastfetch = {
    enable = true;
    # Copied from https://git.obamna.ru/erius/mac-dotfiles/
    settings = {
      logo = {
        type = "kitty";
        source = ./Alya.png;
      };
      display = {
          separator = " ";
          color = {
              "keys" = "35";
          };
      };
      modules = [
        {
          key = "╭───────────╮";
          type =  "custom";
        }
        {
          key = "│ {#31} user    {#keys}│";
          type = "title";
          format = "{user-name}";
        }
        {
          key = "│ {#32}{icon} distro  {#keys}│";
          type = "os";
        }
        {
          key = "│ {#33}󰇄 wm      {#keys}│";
          type = "wm";
        }
        {
          key = "│ {#34}󰍛 cpu     {#keys}│";
          type = "cpu";
        }
        {
          key = "│ {#36} term    {#keys}│";
          type = "terminal";
        }
        {
          key = "│ {#31}󰦨 font    {#keys}│";
          type = "terminalfont";
        }
        {
          key = "│ {#32} shell   {#keys}│";
          type = "shell";
        }
        {
          key = "│ {#33} editor  {#keys}│";
          type = "editor";
        }
        {
          key = "│ {#34} pkgs    {#keys}│";
          type = "packages";
        }
        {
          key = "├───────────┤";
          type = "custom";
        }
        {
          key = "│ {#39} colors  {#keys}│";
          type = "colors";
          symbol = "circle";
        }
        {
          key = "╰───────────╯";
          type = "custom";
        }
      ];
    };
  };
}