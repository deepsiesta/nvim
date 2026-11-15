local highlight_yank = vim.api.nvim_create_augroup("highlight-yank", { clear = true })

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Highlight when yanking (copying) text",
  group = highlight_yank,
  callback = vim.hl.on_yank,
})
