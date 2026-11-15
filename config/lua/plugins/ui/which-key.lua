return {
  "which-key.nvim",
  event = "DeferredUIEnter",
  after = function()
    require("which-key").setup({
      win = { border = "single" },
      spec = {
        { "<leader>b", group = "[B]uffer" },
        { "<leader>c", group = "[C]ode", mode = { "n", "v" } },
        { "<leader>g", group = "[G]it" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>u", group = "[U]I" },
      },
    })
  end,
}
