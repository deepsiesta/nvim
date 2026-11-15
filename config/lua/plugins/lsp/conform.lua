return {
  "conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  after = function()
    require("conform").setup({
      format_on_save = {
        lsp_format = "never",
        timeout_ms = 1000,
      },
      notify_on_error = false,
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "alejandra" },
        rust = { "rustfmt" },
        python = { "ruff_format" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "jq" },
        yaml = { "prettierd" },
        markdown = { "markdownlint" },
        tex = { "latexindent" },
        plaintex = { "latexindent" },
      },
    })
  end,
}
