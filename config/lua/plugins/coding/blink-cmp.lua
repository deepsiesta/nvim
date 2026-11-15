return {
  {
    "friendly-snippets",
    dep_of = { "blink.cmp" },
  },
  {
    "blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    on_require = { "blink.cmp" },
    dep_of = { "nvim-lspconfig", "typescript-tools.nvim" },
    after = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "default",
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
        },

        completion = {
          accept = { auto_brackets = { enabled = true } },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = "single" },
          },
          menu = {
            draw = { treesitter = { "lsp" } },
            border = "single",
          },
        },

        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
          per_filetype = {
            lua = { inherit_defaults = true, "lazydev" },
          },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
            lsp = { score_offset = 3 },
            snippets = { score_offset = 2 },
            path = { score_offset = 1 },
            buffer = { score_offset = 0 },
          },
        },

        signature = {
          enabled = true,
          window = { border = "single" },
        },
      })
    end,
  },
}
