return {
  {
    "nvim-ts-context-commentstring",
    dep_of = { "mini.nvim" },
    before = function()
      -- Context aware commenting, pairs well with mini.comment
      vim.g.skip_ts_context_commentstring_module = true
    end,
    after = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
    end,
  },
  {
    "mini.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("mini.ai").setup({
        n_lines = 500,
      })

      require("mini.surround").setup({
        mappings = {
          add = "gsa",
          delete = "gsd",
          find = "gsf",
          find_left = "gsF",
          highlight = "gsh",
          replace = "gsr",
          update_n_lines = "gsn",
        },
      })

      require("mini.pairs").setup({
        skip_next = [=[[%w%%%'%[%\" ]]=],
        skip_ts = { "string" },
        skip_unbalanced = true,
        markdown = true,
      })

      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })
    end,
  },
}
