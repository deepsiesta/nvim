{pkgs, ...}: {
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

    onAttach = ''
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
      end

      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
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
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
        end, '[T]oggle Inlay [H]ints')
      end
    '';

    keymaps = {
      diagnostic = {
        "<leader>cd" = {
          action = "open_float";
          desc = "Line Diagnostics";
        };
        "]d" = {
          action = "goto_next";
          desc = "Next Diagnostic";
        };
        "[d" = {
          action = "goto_prev";
          desc = "Prev Diagnostic";
        };
      };

      lspBuf = {
        "<leader>ca" = {
          action = "code_action";
          desc = "Code Action";
        };
        "<leader>cr" = {
          action = "rename";
          desc = "Rename";
        };
        "K" = {
          action = "hover";
          desc = "Hover";
        };
        "gD" = {
          action = "declaration";
          desc = "Goto Declaration";
        };
        "gK" = {
          action = "signature_help";
          desc = "Signature Help";
        };
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
          action.__raw = "function() Snacks.picker.lsp_definitions() end";
          options.desc = "Goto Definition";
        }
        {
          mode = "n";
          key = "gr";
          action.__raw = "function() Snacks.picker.lsp_references() end";
          options.desc = "References";
        }
        {
          mode = "n";
          key = "gI";
          action.__raw = "function() Snacks.picker.lsp_implementations() end";
          options.desc = "Goto Implementation";
        }
        {
          mode = "n";
          key = "gy";
          action.__raw = "function() Snacks.picker.lsp_type_definitions() end";
          options.desc = "Goto T[y]pe Definition";
        }
        {
          mode = "n";
          key = "<leader>ss";
          action.__raw = "function() Snacks.picker.lsp_symbols() end";
          options.desc = "LSP Symbols";
        }
        {
          mode = "n";
          key = "<leader>sS";
          action.__raw = "function() Snacks.picker.lsp_workspace_symbols() end";
          options.desc = "LSP Workspace Symbols";
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
  ];
}
