vim.loader.enable()

require("config.options")
require("config.keymaps")
require("config.autocmds")

-- UI
require("plugins.ui.colorscheme")
require("plugins.ui.devicons")
require("plugins.ui.snacks")
require("plugins.ui.noice")
require("plugins.ui.lualine")
require("plugins.ui.which-key")
require("plugins.ui.gitsigns")
require("plugins.ui.render-markdown")

-- Coding
require("plugins.coding.treesitter")
require("plugins.coding.mini")
require("plugins.coding.blink-cmp")
require("plugins.coding.lint")
require("plugins.coding.extra")

-- LSP & Formatting
require("plugins.lsp.lsp")
require("plugins.lsp.conform")
