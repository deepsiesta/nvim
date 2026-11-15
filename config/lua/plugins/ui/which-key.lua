return {
  "which-key.nvim",
  event = "DeferredUIEnter",
  after = function()
    require("which-key").setup({
      win = { border = "single" },
      spec = {
        { "<leader>c", group = "[C]ode" },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk" },
        { "<leader>g", group = "[G]it" },
        { "<leader>f", group = "[F]ind" },
        { "<leader>b", group = "[B]uffer" },
        { "<leader>N", group = "[N]eorg" },
      },
    })
  end,
}
