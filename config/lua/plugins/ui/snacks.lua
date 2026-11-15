local function read_text(name)
  local path = vim.api.nvim_get_runtime_file(name, false)[1]
  return path and table.concat(vim.fn.readfile(path), "\n") or ""
end

require("snacks").setup({
  bigfile = { enabled = true },
  bufdelete = { enabled = true },
  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      {
        icon = " ",
        title = "Keymaps",
        section = "keys",
        indent = 2,
        padding = 1,
      },
    },
    preset = {
      header = read_text("logo.txt") .. "\n\n" .. read_text("title.txt"),
      keys = {
        {
          icon = " ",
          key = "n",
          desc = "New File",
          action = ":ene | startinsert",
        },
        {
          icon = " ",
          key = "r",
          desc = "Recent Files",
          action = ":lua Snacks.dashboard.pick('oldfiles')",
        },
        {
          icon = " ",
          key = "p",
          desc = "Recent Projects",
          action = ":lua Snacks.dashboard.pick('projects')",
        },
        {
          icon = " ",
          key = "q",
          desc = "Quit",
          action = ":qa",
        },
      },
    },
  },
  explorer = { enabled = true },
  styles = { default = { border = "single" } },
  gitbrowse = { enabled = true },
  input = { enabled = true },
  lazygit = { enabled = true },
  notifier = { enabled = true },
  picker = { enabled = true },
  rename = { enabled = true },
  scope = { enabled = true },
  scratch = { enabled = true },
  statuscolumn = { enabled = true },
  terminal = { enabled = true },
  toggle = { enabled = true },
  words = { enabled = true },
  zen = { enabled = true },
  indent = {
    enabled = true,
    indent = {
      priority = 1,
      enabled = true,
      char = "▎",
    },
    scope = {
      enabled = true,
      priority = 200,
      char = "▎",
    },
    chunk = {
      enabled = false,
    },
    animate = {
      enabled = false,
    },
  },
})

local map = vim.keymap.set

-- Top level
map("n", "<leader><leader>", function()
  Snacks.picker.buffers()
end, { desc = "Find existing buffers" })
map("n", "<leader>/", function()
  Snacks.picker.grep_buffers()
end, { desc = "[/] Fuzzily search in open buffers" })
map("n", "<leader>.", function()
  Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", function()
  Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })

-- [S]earch
map("n", "<leader>sh", function()
  Snacks.picker.help()
end, { desc = "[S]earch [H]elp" })
map("n", "<leader>sk", function()
  Snacks.picker.keymaps()
end, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sf", function()
  Snacks.picker.files()
end, { desc = "[S]earch [F]iles" })
map("n", "<leader>ss", function()
  Snacks.picker.pickers()
end, { desc = "[S]earch [S]elect Picker" })
map("n", "<leader>sw", function()
  Snacks.picker.grep_word()
end, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", function()
  Snacks.picker.grep()
end, { desc = "[S]earch by [G]rep" })
map("n", "<leader>sd", function()
  Snacks.picker.diagnostics()
end, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sr", function()
  Snacks.picker.resume()
end, { desc = "[S]earch [R]esume" })
map("n", "<leader>sq", function()
  Snacks.picker.qflist()
end, { desc = "[S]earch [Q]uickfix List" })
map("n", "<leader>s.", function()
  Snacks.picker.recent()
end, { desc = "[S]earch Recent Files ('.' for repeat)" })
map("n", "<leader>sp", function()
  Snacks.picker.projects()
end, { desc = "[S]earch Recent [P]rojects" })

-- [G]it
map("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "Lazygit" })
map("n", "\\", function()
  Snacks.explorer.reveal()
end, { desc = "Explorer Reveal" })
map("n", "<leader>gb", function()
  Snacks.git.blame_line()
end, { desc = "Git Blame Line" })
map("n", "<leader>gB", function()
  Snacks.gitbrowse()
end, { desc = "Git Browse" })
map("n", "<leader>gl", function()
  Snacks.lazygit.log()
end, { desc = "Lazygit Log (cwd)" })
map("n", "<leader>gf", function()
  Snacks.lazygit.log_file()
end, { desc = "Lazygit Current File History" })

-- UI/UX
map("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Explorer" })
map("n", "<leader>n", function()
  Snacks.notifier.show_history()
end, { desc = "Notification History" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>cR", function()
  Snacks.rename.rename_file()
end, { desc = "Rename File" })
map("n", "<leader>un", function()
  Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })
map("n", "<leader>z", function()
  Snacks.zen()
end, { desc = "Toggle Zen Mode" })
map("n", "<leader>Z", function()
  Snacks.zen.zoom()
end, { desc = "Toggle Zoom" })

-- Toggles
map("n", "<leader>ub", function()
  Snacks.toggle.background():toggle()
end, { desc = "Toggle Background" })
map("n", "<leader>uf", function()
  Snacks.toggle.format():toggle()
end, { desc = "Toggle Auto Format" })
map("n", "<leader>ul", function()
  Snacks.toggle.line_number():toggle()
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ui", function()
  Snacks.toggle.indent():toggle()
end, { desc = "Toggle Indent Guides" })
map("n", "<leader>us", function()
  Snacks.toggle.scroll():toggle()
end, { desc = "Toggle Smooth Scroll" })
map("n", "<leader>uw", function()
  Snacks.toggle.wrap():toggle()
end, { desc = "Toggle Wrap" })
