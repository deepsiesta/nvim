require("tokyonight").setup({
  style = "night",
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
    keywords = { italic = false },
  },
})

vim.cmd.colorscheme("tokyonight")
