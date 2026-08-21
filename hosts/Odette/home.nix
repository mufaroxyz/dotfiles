{ lib, pkgs, ... }:
{
  imports = [
    ../../modules/home/desktop-apps.nix
    ../../modules/home/coding-agents.nix
  ];

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.t3code
    pkgs.aerospace
  ];

  # SketchyBar visual style adapted from hrtowii/dotfiles (macos branch):
  # https://github.com/hrtowii/dotfiles
  home.file.".config/sketchybar/sketchybarrc" = {
    executable = true;
    text = ''
      #!${pkgs.lua5_5}/bin/lua

      -- Adapted from https://github.com/hrtowii/dotfiles (macos branch)
      package.cpath = "${pkgs.sbarlua}/lib/lua/5.5/?.so;" .. package.cpath

      local sbar = require("sketchybar")
      local app_icons = dofile("${pkgs.sketchybar-app-font}/lib/sketchybar-app-font/icon_map.lua")

      local colors = {
        black = 0xff232136,
        white = 0xffe0def4,
        blue = 0xff9ccfd8,
        grey = 0xff6e6a86,
        transparent = 0x00000000,
        bar = {
          bg = 0xff2a273f,
          border = 0xff524f67,
        },
        popup = {
          bg = 0xc0393552,
          border = 0xff44415a,
        },
        bg1 = 0xff2a283e,
        bg2 = 0xff393552,
      }

      function colors.with_alpha(color, alpha)
        return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
      end

      local settings = {
        paddings = 3,
        group_paddings = 5,
        font = {
          text = "Monaspace Neon Var",
          numbers = "Monaspace Neon Var",
          space_numbers = "Monaspace Neon Var",
          style_map = {
            ["Regular"] = "Regular",
            ["Semibold"] = "Medium",
            ["Bold"] = "SemiBold",
            ["Heavy"] = "Bold",
            ["Black"] = "ExtraBold",
          },
        },
      }

      local workspaces = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
      local spaces = {}
      local current_focused_workspace = nil

      local function focused_workspace()
        local process = io.popen("aerospace list-workspaces --focused")
        if process == nil then
          return "1"
        end

        local workspace = process:read("*l")
        process:close()
        return workspace or "1"
      end

      local function set_space_highlight(workspace, selected)
        local space = spaces[workspace]
        if space == nil or space.highlighted == selected then
          return
        end

        space.item:set({
          icon = { highlight = selected },
          label = { highlight = selected },
          background = { border_color = selected and colors.black or colors.bg2 },
        })
        space.bracket:set({
          background = { border_color = selected and colors.grey or colors.bg2 },
        })
        space.highlighted = selected
      end

      local function update_highlight(focused)
        if current_focused_workspace and current_focused_workspace ~= focused then
          set_space_highlight(current_focused_workspace, false)
        end
        set_space_highlight(focused, true)
        current_focused_workspace = focused
      end

      local function refresh_spaces()
        sbar.exec(
          "aerospace list-windows --all --format '%{workspace}|%{app-name}'",
          function(output)
            local workspace_apps = {}
            for line in output:gmatch("[^\r\n]+") do
              local workspace, app = line:match("^([^|]+)|(.*)$")
              if workspace and app then
                workspace_apps[workspace] = workspace_apps[workspace] or {}
                workspace_apps[workspace][app] = true
              end
            end

            for workspace, space in pairs(spaces) do
              local label = ""
              for app in pairs(workspace_apps[workspace] or {}) do
                label = label .. (app_icons[app] or app_icons.default)
              end
              if label == "" then
                label = "-"
              end

              if space.label ~= label then
                space.item:set({ label = { string = label } })
                space.label = label
              end
            end
          end
        )
      end

      sbar.begin_config()

      sbar.bar({
        topmost = "on",
        height = 40,
        color = colors.transparent,
        padding_right = 5,
        padding_left = 5,
        blur_radius = 30,
        shadow = false,
        y_offset = 0,
        margin = 0,
        corner_radius = 5,
      })

      sbar.default({
        updates = "when_shown",
        icon = {
          font = {
            family = settings.font.text,
            style = settings.font.style_map["Bold"],
            size = 14.0,
          },
          color = colors.white,
          padding_left = settings.paddings,
          padding_right = settings.paddings,
          background = { image = { corner_radius = 9 } },
        },
        label = {
          font = {
            family = settings.font.text,
            style = settings.font.style_map["Semibold"],
            size = 13.0,
          },
          color = colors.white,
          padding_left = settings.paddings,
          padding_right = settings.paddings,
        },
        background = {
          height = 28,
          corner_radius = 9,
          border_width = 1,
          border_color = colors.with_alpha(colors.bg2, 0.7),
          image = {
            corner_radius = 9,
            border_color = colors.with_alpha(colors.grey, 0.6),
            border_width = 1,
          },
        },
        popup = {
          background = {
            border_width = 2,
            corner_radius = 9,
            border_color = colors.popup.border,
            color = colors.with_alpha(colors.popup.bg, 0.35),
            shadow = { drawing = true },
          },
          blur_radius = 30,
        },
        padding_left = 5,
        padding_right = 5,
        scroll_texts = true,
      })

      sbar.add("event", "aerospace_workspace_change")
      sbar.add("event", "aerospace_focus_change")

      sbar.add("item", { position = "left", width = 5 })

      local apple = sbar.add("item", "apple", {
        position = "left",
        icon = {
          font = { family = "SF Pro", size = 16.0 },
          string = "",
          padding_left = 8,
          padding_right = 8,
        },
        label = { drawing = false },
        background = {
          color = colors.bg2,
          border_color = colors.black,
          border_width = 1,
        },
        padding_left = 1,
        padding_right = 1,
      })

      sbar.add("bracket", { apple.name }, {
        background = {
          color = colors.transparent,
          height = 30,
          border_color = colors.grey,
        },
      })
      sbar.add("item", { position = "left", width = 7 })

      for _, workspace in ipairs(workspaces) do
        local space = sbar.add("item", "space." .. workspace, {
          position = "left",
          icon = {
            font = { family = settings.font.space_numbers },
            string = workspace,
            padding_left = 8,
            padding_right = 3,
            color = colors.white,
            highlight_color = colors.blue,
            y_offset = 1,
          },
          label = {
            padding_left = 4,
            padding_right = 10,
            color = colors.grey,
            highlight_color = colors.white,
            font = "sketchybar-app-font:Regular:16.0",
            string = "-",
          },
          padding_left = 1,
          padding_right = 1,
          background = {
            color = colors.bg1,
            border_width = 1,
            height = 26,
            border_color = colors.black,
          },
        })

        local bracket = sbar.add("bracket", "space." .. workspace .. ".bracket", { space.name }, {
          background = {
            color = colors.transparent,
            border_color = colors.bg2,
            height = 28,
            border_width = 2,
          },
        })

        sbar.add("item", "space.padding." .. workspace, {
          position = "left",
          width = settings.group_paddings,
        })

        spaces[workspace] = {
          item = space,
          bracket = bracket,
          label = "",
          highlighted = false,
        }

        space:subscribe("mouse.clicked", function()
          sbar.exec("aerospace workspace " .. workspace)
        end)
      end

      local front_app = sbar.add("item", "front_app", {
        display = "active",
        icon = { drawing = false },
        label = {
          font = {
            style = settings.font.style_map["Black"],
            size = 12.0,
          },
        },
        updates = true,
      })

      front_app:subscribe("front_app_switched", function(env)
        front_app:set({ label = { string = env.INFO } })
      end)

      sbar.add("item", { position = "right", width = settings.group_paddings })

      local calendar = sbar.add("item", "calendar", {
        icon = {
          color = colors.white,
          padding_left = 8,
          font = {
            style = settings.font.style_map["Black"],
            size = 12.0,
          },
        },
        label = {
          color = colors.white,
          padding_right = 8,
          width = 49,
          align = "right",
          font = { family = settings.font.numbers },
        },
        position = "right",
        update_freq = 30,
        padding_left = 1,
        padding_right = 1,
        background = {
          color = colors.bg2,
          border_width = 1,
          border_color = colors.black,
        },
      })

      sbar.add("bracket", { calendar.name }, {
        background = {
          color = colors.transparent,
          height = 30,
          border_color = colors.grey,
        },
      })
      sbar.add("item", { position = "right", width = settings.group_paddings })

      calendar:subscribe({ "forced", "routine", "system_woke" }, function()
        calendar:set({
          icon = os.date("%a. %d %b."),
          label = os.date("%H:%M"),
        })
      end)

      local function system_card(name, icon, label, script, update_freq, click_script)
        local card = sbar.add("item", name, {
          position = "right",
          script = script,
          update_freq = update_freq,
          click_script = click_script,
          icon = {
            string = icon,
            font = { family = "Monaspace Neon NF", style = "Regular", size = 14.0 },
            padding_left = 8,
            padding_right = 4,
          },
          label = {
            string = label,
            padding_right = 8,
          },
          padding_left = 1,
          padding_right = 1,
          background = {
            color = colors.bg2,
            border_width = 1,
            border_color = colors.black,
          },
        })

        sbar.add("bracket", name .. ".bracket", { card.name }, {
          background = {
            color = colors.transparent,
            height = 30,
            border_color = colors.grey,
          },
        })
        sbar.add("item", { position = "right", width = settings.group_paddings })
      end

      system_card(
        "battery",
        "",
        "",
        "/Users/mufaro/.config/sketchybar/widgets.sh battery",
        60,
        nil
      )
      system_card(
        "media",
        "",
        "",
        "/Users/mufaro/.config/sketchybar/widgets.sh media",
        5,
        "/Users/mufaro/.config/sketchybar/media-toggle.sh"
      )

      local observer = sbar.add("item", "aerospace.observer", { drawing = false })
      observer:subscribe({ "aerospace_workspace_change", "aerospace_focus_change" }, function(env)
        update_highlight(env.FOCUSED_WORKSPACE or focused_workspace())
        refresh_spaces()
      end)

      sbar.end_config()
      update_highlight(focused_workspace())
      refresh_spaces()
      os.execute("/Users/mufaro/.config/sketchybar/aerospace.sh")
      sbar.event_loop()
    '';
  };

  home.file.".config/sketchybar/aerospace.sh" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash

      aerospace=${pkgs.aerospace}/bin/aerospace
      icon_map=${pkgs.sketchybar-app-font}/bin/icon_map.sh
      sketchybar=/run/current-system/sw/bin/sketchybar
      focused="$($aerospace list-workspaces --focused)"
      apps="$($aerospace list-windows --all --format '%{workspace}|%{app-name}')"

      for workspace in {1..9}; do
        icons=""
        while IFS='|' read -r app_workspace app; do
          [ "$app_workspace" = "$workspace" ] || continue
          icons+="$($icon_map "$app")"
        done <<< "$apps"

        [ -n "$icons" ] || icons="-"
        if [ "$workspace" = "$focused" ]; then
          $sketchybar --set "space.$workspace" \
            label="$icons" \
            icon.highlight=on \
            label.highlight=on \
            background.border_color=0xff232136
          $sketchybar --set "space.$workspace.bracket" background.border_color=0xff6e6a86
        else
          $sketchybar --set "space.$workspace" \
            label="$icons" \
            icon.highlight=off \
            label.highlight=off \
            background.border_color=0xff393552
          $sketchybar --set "space.$workspace.bracket" background.border_color=0xff393552
        fi
      done
    '';
  };

  home.file.".config/sketchybar/widgets.sh" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash

      nowplaying=${pkgs.nowplaying-cli}/bin/nowplaying-cli
      sketchybar=/run/current-system/sw/bin/sketchybar

      case "$1" in
        battery)
          output=$(/usr/bin/pmset -g batt | /usr/bin/tail -n 1)
          percent=$(printf '%s' "$output" | /usr/bin/grep -oE '[0-9]+%' | /usr/bin/head -n 1 | /usr/bin/tr -d '%')
          if printf '%s' "$output" | /usr/bin/grep -q 'charging'; then
            icon=$'\uF0E7'
          elif printf '%s' "$output" | /usr/bin/grep -q 'charged'; then
            icon=$'\uF240'
          elif [[ "$percent" -ge 75 ]]; then
            icon=$'\uF240'
          elif [[ "$percent" -ge 50 ]]; then
            icon=$'\uF241'
          elif [[ "$percent" -ge 25 ]]; then
            icon=$'\uF242'
          else
            icon=$'\uF243'
          fi
          $sketchybar --set "$NAME" drawing=on icon="$icon" label="$percent%"
          ;;
        media)
          title=$($nowplaying get title 2>/dev/null)
          artist=$($nowplaying get artist 2>/dev/null)
          if [[ -z "$title" || "$title" == "null" ]]; then
            title=$(/usr/bin/osascript -e 'tell application "Spotify" to get name of current track' 2>/dev/null)
            artist=$(/usr/bin/osascript -e 'tell application "Spotify" to get artist of current track' 2>/dev/null)
          fi
          if [[ -z "$title" || "$title" == "null" ]]; then
            $sketchybar --set "$NAME" drawing=off
          elif [[ -z "$artist" || "$artist" == "null" ]]; then
            $sketchybar --set "$NAME" drawing=on label="$title"
          else
            $sketchybar --set "$NAME" drawing=on label="$title - $artist"
          fi
          ;;
      esac
    '';
  };

  home.file.".config/sketchybar/media-toggle.sh" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash

      nowplaying=${pkgs.nowplaying-cli}/bin/nowplaying-cli
      title=$($nowplaying get title 2>/dev/null)
      if [[ -n "$title" && "$title" != "null" ]]; then
        exec $nowplaying togglePlayPause
      fi

      exec /usr/bin/osascript -e 'tell application "Spotify" to playpause'
    '';
  };

  home.file.".aerospace.toml".text = ''
    config-version = 2
    persistent-workspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    start-at-login = false

    after-startup-command = [
      "exec-and-forget /Users/mufaro/.config/sketchybar/aerospace.sh",
    ]

    exec-on-workspace-change = [
      "/Users/mufaro/.config/sketchybar/aerospace.sh",
    ]

    on-focus-changed = [
      "exec-and-forget /Users/mufaro/.config/sketchybar/aerospace.sh",
    ]

    [gaps]
    inner.horizontal = 8
    inner.vertical = 8
    outer.left = 8
    outer.bottom = 8
    outer.top = 8
    outer.right = 8

    [mode.main.binding]
    alt-enter = "exec-and-forget open -na Terminal"
    alt-h = "focus left"
    alt-j = "focus down"
    alt-k = "focus up"
    alt-l = "focus right"
    alt-shift-h = "move left"
    alt-shift-j = "move down"
    alt-shift-k = "move up"
    alt-shift-l = "move right"
    alt-f = "fullscreen"
    alt-slash = "layout floating tiling"
    alt-1 = "workspace 1"
    alt-2 = "workspace 2"
    alt-3 = "workspace 3"
    alt-4 = "workspace 4"
    alt-5 = "workspace 5"
    alt-6 = "workspace 6"
    alt-7 = "workspace 7"
    alt-8 = "workspace 8"
    alt-9 = "workspace 9"
    alt-shift-1 = "move-node-to-workspace 1"
    alt-shift-2 = "move-node-to-workspace 2"
    alt-shift-3 = "move-node-to-workspace 3"
    alt-shift-4 = "move-node-to-workspace 4"
    alt-shift-5 = "move-node-to-workspace 5"
    alt-shift-6 = "move-node-to-workspace 6"
    alt-shift-7 = "move-node-to-workspace 7"
    alt-shift-8 = "move-node-to-workspace 8"
    alt-shift-9 = "move-node-to-workspace 9"
  '';

  launchd.agents.aerospace = {
    enable = true;
    config = {
      ProgramArguments = [ "${pkgs.aerospace}/Applications/AeroSpace.app/Contents/MacOS/AeroSpace" ];
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "/tmp/aerospace.log";
      StandardErrorPath = "/tmp/aerospace.err.log";
    };
  };

  programs.codex = {
    settings.mcp_servers.chrome-devtools = {
      command = "npx";
      args = [
        "-y"
        "chrome-devtools-mcp@latest"
        "--headless"
      ];
      enabled = true;
      startup_timeout_sec = 30;
      tool_timeout_sec = 120;
    };
    settings.model_providers.openrouter = lib.mkForce {
      name = "OpenRouter";
      base_url = "https://openrouter.ai/api/v1";
      wire_api = "responses";
      auth = {
        command = "/usr/bin/security";
        args = [
          "find-generic-password"
          "-a"
          "mufaro"
          "-s"
          "OPENROUTER_API_KEY"
          "-w"
        ];
      };
    };
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
