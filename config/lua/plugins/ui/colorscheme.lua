require("tokyonight").setup({
  style = "night",
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
    keywords = { italic = false },
  },
  on_highlights = function(hl)
    hl.CursorLine = { bg = "NONE" }
    hl.SnacksIndent = { link = "NonText" }
  end,
})

vim.cmd.colorscheme("tokyonight")
