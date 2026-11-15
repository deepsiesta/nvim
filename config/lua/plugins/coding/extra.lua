return {
  {
    "plenary.nvim",
    dep_of = { "todo-comments.nvim", "typescript-tools.nvim" },
  },
  {
    "todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    after = function()
      require("todo-comments").setup({
        signs = true,
      })
    end,
  },
  {
    "vim-nix",
    ft = "nix",
  },
  {
    "nix-develop.nvim",
    cmd = { "DevenvShell", "NixDevelop", "NixShell", "RiffShell" },
  },
  {
    "vimtex",
    ft = { "tex", "plaintex", "bib" },
    before = function()
      vim.g.vimtex_view_method = "general"
    end,
  },
}
