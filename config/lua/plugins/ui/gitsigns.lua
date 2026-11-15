return {
  "gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  after = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    })

    local gs = require("gitsigns")
    local map = vim.keymap.set

    -- Navigation
    map("n", "]h", function()
      gs.nav_hunk("next")
    end, { desc = "Next Git [H]unk" })
    map("n", "[h", function()
      gs.nav_hunk("prev")
    end, { desc = "Prev Git [H]unk" })

    -- Actions
    map("n", "<leader>hs", gs.stage_hunk, { desc = "git [s]tage hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "git [r]eset hunk" })
    map("v", "<leader>hs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "stage git hunk" })
    map("v", "<leader>hr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "reset git hunk" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "git [S]tage buffer" })
    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "git [R]eset buffer" })
    map("n", "<leader>hp", gs.preview_hunk, { desc = "git [p]review hunk" })
    map("n", "<leader>hb", gs.blame_line, { desc = "git [b]lame line" })
    map("n", "<leader>hd", gs.diffthis, { desc = "git [d]iff against index" })
    map("n", "<leader>hD", function()
      gs.diffthis("~")
    end, { desc = "git [D]iff against last commit" })

    -- Toggles
    map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
    map("n", "<leader>td", gs.toggle_deleted, { desc = "[T]oggle git show [d]eleted" })
  end,
}
