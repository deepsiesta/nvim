local highlight_yank = vim.api.nvim_create_augroup("highlight-yank", { clear = true })

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Highlight when yanking (copying) text",
  group = highlight_yank,
  callback = vim.hl.on_yank,
})

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Remove cursor highlight background and set indent guide color",
  command = "highlight CursorLine guibg=NONE | highlight! link SnacksIndent NonText",
})
