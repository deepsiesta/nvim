{pkgs, ...}: {
  diagnostic.settings = {
    virtual_text = true;
    float.border = "single";
  };

  plugins.lsp = {
    enable = true;
    inlayHints = true;

    onAttach = ''
      if client.supports_method('textDocument/documentHighlight') then
        local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
          end,
        })
      end
    '';

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
    ty
  ];
}
