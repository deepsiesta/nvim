{pkgs, ...}: {
  diagnostic.settings = {
    virtual_text = true;
  };

  clipboard = {
    register = "unnamedplus";
    providers = {
      wl-copy.enable = true;
      xsel.enable = true;
    };
  };

  autoGroups = {
    "kickstart-lsp-attach" = {
      clear = true;
    };
  };

  autoCmd = [
    {
      event = ["CursorHold" "CursorHoldI"];
      group = "kickstart-lsp-attach";
      callback.__raw =
        # Lua
        ''
          function()
            vim.lsp.buf.document_highlight()
          end
        '';
    }
    {
      event = ["CursorMoved" "CursorMovedI"];
      group = "kickstart-lsp-attach";
      callback.__raw =
        # Lua
        ''
          function()
            vim.lsp.buf.clear_references()
          end
        '';
    }
  ];

  plugins.lsp = {
    enable = true;
    inlayHints = true;

    servers = {
      ty.enable = true;
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      jsonls.enable = true;
      html.enable = true;
      eslint.enable = true;
      cssls.enable = true;
      tailwindcss.enable = true;
      nushell.enable = true;
      nixd.enable = true;

      lua_ls = {
        enable = true;
        settings.completion.callSnippet = "Replace";
      };
    };

    keymaps = {
      diagnostic = {
        "<leader>cd" = "open_float";
        "]d" = "goto_next";
        "[d" = "goto_prev";
      };

      lspBuf = {
        "<leader>ca" = "code_action";
        "<leader>cr" = "rename";
        "K" = "hover";
        "gD" = "declaration";
        "gK" = "signature_help";
        "gI" = "implementation";
      };

      extra = [
        {
          mode = "n";
          key = "<leader>cl";
          action = "<cmd>LspInfo<cr>";
          options.desc = "LSP Info";
        }
        {
          mode = "n";
          key = "gd";
          action = "<cmd>lua Snacks.picker.lsp_definitions()<CR>";
          options.desc = "Goto Definition";
        }
        {
          mode = "n";
          key = "gr";
          action = "<cmd>lua Snacks.picker.lsp_references()<CR>";
          options.desc = "References";
        }
        {
          mode = "n";
          key = "gy";
          action = "<cmd>lua Snacks.picker.lsp_type_definitions()<CR>";
          options.desc = "Goto T[y]pe Definition";
        }
        {
          mode = "n";
          key = "<leader>ss";
          action = "<cmd>lua Snacks.picker.lsp_symbols()<CR>";
          options.desc = "LSP Symbols";
        }
        {
          mode = "n";
          key = "<leader>sS";
          action = "<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>";
          options.desc = "LSP Workspace Symbols";
        }
        {
          mode = "n";
          key = "<leader>th";
          action = "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>";
          options.desc = "[T]oggle Inlay [H]ints";
        }
      ];
    };
  };

  plugins.fidget.enable = true;
  plugins.typescript-tools.enable = true;

  extraPlugins = with pkgs.vimPlugins; [luvit-meta];

  extraPackages = with pkgs; [
    nodejs
    typescript
    typescript-language-server
    nixd
    nixpkgs-fmt
    wl-clipboard
    xsel
    lazygit
  ];
}
