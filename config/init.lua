vim.loader.enable()

local ok_nix, nixInfo = pcall(require, vim.g.nix_info_plugin_name or "nix-info")
if not ok_nix then
  nixInfo = function(default)
    return default
  end
end

local lze = setmetatable(require("lze"), getmetatable(require("lzextras")))
lze.register_handlers({ lze.lsp })
lze.h.lsp.set_ft_fallback(function(name)
  local lspcfg = nixInfo(nil, "plugins", "lazy", "nvim-lspconfig") or nixInfo(nil, "plugins", "start", "nvim-lspconfig")
  if lspcfg then
    local ok, cfg = pcall(dofile, lspcfg .. "/lsp/" .. name .. ".lua")
    return (ok and cfg or {}).filetypes or {}
  end
  return (vim.lsp.config[name] or {}).filetypes or {}
end)

require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Eager UI & core plugins
require("plugins.ui.colorscheme")
require("plugins.ui.devicons")
require("plugins.ui.snacks")
require("plugins.ui.noice")
require("plugins.ui.lualine")

-- Lazy plugin specs
lze.load({
  -- UI
  require("plugins.ui.which-key"),
  require("plugins.ui.gitsigns"),
  require("plugins.ui.render-markdown"),

  -- Coding
  require("plugins.coding.treesitter"),
  require("plugins.coding.mini"),
  require("plugins.coding.blink-cmp"),
  require("plugins.coding.lint"),
  require("plugins.coding.extra"),

  -- LSP & Formatting
  require("plugins.lsp.lsp"),
  require("plugins.lsp.conform"),
})
