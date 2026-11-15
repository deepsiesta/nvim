local ts_augroup = vim.api.nvim_create_augroup("treesitter-attach", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = ts_augroup,
  pattern = "*",
  callback = function(args)
    local buf = args.buf
    local filetype = vim.bo[buf].filetype
    local lang = vim.treesitter.language.get_lang(filetype)
    if not lang then
      return
    end
    if not vim.treesitter.language.add(lang) then
      return
    end

    if vim.treesitter.query.get(lang, "highlights") ~= nil then
      vim.treesitter.start(buf, lang)
    end
    if vim.treesitter.query.get(lang, "indents") ~= nil then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
  },
})

local select_textobject = function(query)
  return function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
  end
end

vim.keymap.set({ "x", "o" }, "af", select_textobject("@function.outer"), { desc = "Select outer function" })
vim.keymap.set({ "x", "o" }, "if", select_textobject("@function.inner"), { desc = "Select inner function" })
vim.keymap.set({ "x", "o" }, "ac", select_textobject("@class.outer"), { desc = "Select outer class" })
vim.keymap.set({ "x", "o" }, "ic", select_textobject("@class.inner"), { desc = "Select inner class" })

require("nvim-ts-autotag").setup({})
