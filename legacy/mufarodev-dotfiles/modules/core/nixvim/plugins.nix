{pkgs, ...}: {
  programs.nixvim.plugins = {
    bufferline.enable = true;
    lualine.enable = true;
    oil.enable = true;
    neoscroll.enable = true;
    treesitter.enable = true;
    ts-autotag.enable = true;
    nvim-autopairs.enable = true;
    none-ls = {
      enable = true;
      settings = {
        cmd = ["bash -c nvim"];
        debug = true;
      };
      sources = {
        code_actions = {
          statix.enable = true;
          gitsigns.enable = true;
        };
        diagnostics = {
          statix.enable = true;
          deadnix.enable = true;
          pylint.enable = true;
          checkstyle.enable = true;
        };
        formatting = {
          alejandra.enable = true;
          stylua.enable = true;
          shfmt.enable = true;
          nixpkgs_fmt.enable = true;
          google_java_format.enable = false;
          prettier = {
            enable = true;
            disableTsServerFormatter = true;
          };
          black = {
            enable = true;
            settings = ''
              {
                extra_args = { "--fast" },
              }
            '';

          };
        };
        completion = {
          luasnip.enable = true;
          spell.enable = true;
        };
      };
    };

    lazygit = {
      enable = true;
    };

    notify = {
      enable = true;
      backgroundColour = "#1e1e2e";
      fps = 60;
      render = "default";
      timeout = 500;
      topDown = true;
    };

    lint = {
      enable = true;
      lintersByFt = {
        text = ["vale"];
        json = ["jsonlint"];
        markdown = ["vale"];
        rst = ["vale"];
        ruby = ["ruby"];
        janet = ["janet"];
        inko = ["inko"];
        clojure = ["clj-kondo"];
        dockerfile = ["hadolint"];
        terraform = ["tflint"];
      };
    };
    
    commentary.enable = true;

    toggleterm = {
      enable = true;
      settings = {
        hide_numbers = false;
        autochdir = true;
        close_on_exit = true;
        direction = "vertical";
      };
    };

    gitsigns = {
      enable = true;
      settings.current_line_blame = true;
    };

    which-key = {
      enable = true;
      registrations = {
        "<leader>fg" = "Find Git files with telescope";
        "<leader>fw" = "Find text with telescope";
        "<leader>ff" = "Find files with telescope";
      };
    };

    noice = {
      enable = true;
    };

    telescope = {
      enable = true;
      extensions = {
        fzf-native = {
          enable = true;
        };
      };
    };

    neo-tree = {
      enable = true;
      enableDiagnostics = true;
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;
      closeIfLastWindow = true;
      popupBorderStyle = "rounded"; # Type: null or one of “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
      buffers = {
        bindToCwd = false;
        followCurrentFile = {
          enabled = true;
        };
      };
      window = {
        width = 40;
        height = 15;
        autoExpandWidth = false;
        mappings = {
          "<space>" = "none";
        };
      };
    };

    undotree = {
      enable = true;
      settings = {
        autoOpenDiff = true;
        focusOnToggle = true;
      };
    };

    illuminate = {
      enable = true;
      underCursor = false;
      filetypesDenylist = [
        "Outline"
        "TelescopePrompt"
        "alpha"
        "harpoon"
        "reason"
      ];
    };

    nix = {
      enable = true;
    };

    lsp = {
      enable = true;
      servers = {
        # Average webdev LSPs
        tsserver.enable = true; # TS/JS
        cssls.enable = true; # CSS
        tailwindcss.enable = true; # TailwindCSS
        html.enable = true; # HTML
        astro.enable = true; # AstroJS
        phpactor.enable = true; # PHP
        svelte.enable = false; # Svelte
        vuels.enable = false; # Vue
        pyright.enable = true; # Python
        marksman.enable = true; # Markdown
        nil-ls.enable = true; # Nix
        dockerls.enable = true; # Docker
        bashls.enable = true; # Bash
        clangd.enable = true; # C/C++
        csharp-ls.enable = true; # C#
        yamlls.enable = true; # YAML

        lua-ls = { # Lua
          enable = true;
          settings.telemetry.enable = false;
        };

        # Rust
        rust-analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };
      };
    };
    
        cmp-emoji = {
      enable = true;
    };

    cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        experimental = { ghost_text = true; };
        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };
        snippet = { expand = "luasnip"; };
        formatting = { fields = [ "kind" "abbr" "menu" ]; };
        sources = [
          { name = "nvim_lsp"; }
          { name = "emoji"; }
          {
            name = "buffer"; # text within current buffer
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            keywordLength = 3;
          }
          # { name = "copilot"; } # enable/disable copilot
          {
            name = "path"; # file system paths
            keywordLength = 3;
          }
          {
            name = "luasnip"; # snippets
            keywordLength = 3;
          }
        ];

        window = {
          completion = { border = "solid"; };
          documentation = { border = "solid"; };
        };

        mapping = {
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
        };
      };
    };
    cmp-nvim-lsp = {
      enable = true; # LSP
    };
    cmp-buffer = {
      enable = true;
    };
    cmp-path = {
      enable = true; # file system paths
    };
    cmp_luasnip = {
      enable = true; # snippets
    };
    cmp-cmdline = {
      enable = true; # autocomplete for cmdline
    }; 

    lspkind = {
      enable = true;
      symbolMap = {
        Copilot = "";
      };
      extraOptions = {
        maxwidth = 50;
        ellipsis_char = "...";
      };
    };

    schemastore = {
      enable = true;
      yaml.enable = true;
      json.enable = false;
    };

    fidget = {
      enable = true;
      logger = {
        level = "warn"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
        floatPrecision = 0.01; # Limit the number of decimals displayed for floats
      };
      progress = {
        pollRate = 0; # How and when to poll for progress messages
        suppressOnInsert = true; # Suppress new messages while in insert mode
        ignoreDoneAlready = false; # Ignore new tasks that are already complete
        ignoreEmptyMessage = false; # Ignore new tasks that don't contain a message
        clearOnDetach =
          # Clear notification group when LSP server detaches
          ''
            function(client_id)
              local client = vim.lsp.get_client_by_id(client_id)
              return client and client.name or nil
            end
          '';
        notificationGroup =
          # How to get a progress message's notification group key
          ''
            function(msg) return msg.lsp_client.name end
          '';
        ignore = [ ]; # List of LSP servers to ignore
        lsp = {
          progressRingbufSize = 0; # Configure the nvim's LSP progress ring buffer size
        };
        display = {
          renderLimit = 16; # How many LSP messages to show at once
          doneTtl = 3; # How long a message should persist after completion
          doneIcon = "✔"; # Icon shown when all LSP progress tasks are complete
          doneStyle = "Constant"; # Highlight group for completed LSP tasks
          progressTtl = "math.huge"; # How long a message should persist when in progress
          progressIcon = {
            pattern = "dots";
            period = 1;
          }; # Icon shown when LSP progress tasks are in progress
          progressStyle = "WarningMsg"; # Highlight group for in-progress LSP tasks
          groupStyle = "Title"; # Highlight group for group name (LSP server name)
          iconStyle = "Question"; # Highlight group for group icons
          priority = 30; # Ordering priority for LSP notification group
          skipHistory = true; # Whether progress notifications should be omitted from history
          formatMessage = ''
            require ("fidget.progress.display").default_format_message
          ''; # How to format a progress message
          formatAnnote = ''
            function (msg) return msg.title end
          ''; # How to format a progress annotation
          formatGroupName = ''
            function (group) return tostring (group) end
          ''; # How to format a progress notification group's name
          overrides = {
            rust_analyzer = {
              name = "rust-analyzer";
            };
          }; # Override options from the default notification config
        };
      };
      notification = {
        pollRate = 10; # How frequently to update and render notifications
        filter = "info"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
        historySize = 128; # Number of removed messages to retain in history
        overrideVimNotify = true;
        redirect = ''
          function(msg, level, opts)
            if opts and opts.on_open then
              return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
            end
          end
        '';
        configs = {
          default = "require('fidget.notification').default_config";
        };

        window = {
          normalHl = "Comment";
          winblend = 0;
          border = "none"; # none, single, double, rounded, solid, shadow
          zindex = 45;
          maxWidth = 0;
          maxHeight = 0;
          xPadding = 1;
          yPadding = 0;
          align = "bottom";
          relative = "editor";
        };
        view = {
          stackUpwards = true; # Display notification items from bottom to top
          iconSeparator = " "; # Separator between group name and icon
          groupSeparator = "---"; # Separator between notification groups
          groupSeparatorHl =
            # Highlight group used for group separator
            "Comment";
        };
      };
    };

  };
}
