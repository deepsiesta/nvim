require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

local map = vim.keymap.set

-- Navigation
map("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next Git [H]unk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Prev Git [H]unk" })

-- Actions
map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "git [s]tage hunk" })
map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "git [r]eset hunk" })
map("v", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "stage git hunk" })
map("v", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "reset git hunk" })
map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "git [S]tage buffer" })
map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "git [u]ndo stage hunk" })
map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "git [R]eset buffer" })
map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "git [p]review hunk" })
map("n", "<leader>hb", "<cmd>Gitsigns blame_line<CR>", { desc = "git [b]lame line" })
map("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>", { desc = "git [d]iff against index" })
map("n", "<leader>hD", function()
  require("gitsigns").diffthis("~")
end, { desc = "git [D]iff against last commit" })

-- Toggles
map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "[T]oggle git show [b]lame line" })
map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>", { desc = "[T]oggle git show [d]eleted" })
