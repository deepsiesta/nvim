vim.diagnostic.config({
  virtual_text = true,
  float = { border = "single" },
})

vim.lsp.inlay_hint.enable(true)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local bufnr = event.buf

    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    map("<leader>cd", vim.diagnostic.open_float, "Open floating diagnostic message")
    map("]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "Next diagnostic")
    map("[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "Previous diagnostic")

    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>cr", vim.lsp.buf.rename, "Rename")
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("gD", vim.lsp.buf.declaration, "Goto declaration")
    map("gK", vim.lsp.buf.signature_help, "Signature help")
    map("gI", vim.lsp.buf.implementation, "Goto implementation")

    map("<leader>cl", "<cmd>checkhealth vim.lsp<CR>", "LSP Info")
    map("gd", "<cmd>lua Snacks.picker.lsp_definitions()<CR>", "Goto Definition")
    map("gr", "<cmd>lua Snacks.picker.lsp_references()<CR>", "References")
    map("gy", "<cmd>lua Snacks.picker.lsp_type_definitions()<CR>", "Goto T[y]pe Definition")
    map("<leader>cs", "<cmd>lua Snacks.picker.lsp_symbols()<CR>", "LSP Symbols")
    map("<leader>cS", "<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>", "LSP Workspace Symbols")
    map(
      "<leader>th",
      "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
      "[T]oggle Inlay [H]ints"
    )
  end,
})

return {
  {
    "luvit-meta",
    dep_of = { "lazydev.nvim" },
  },
  {
    "lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    after = function()
      local lib_dir = vim.api.nvim_get_runtime_file("library", false)[1]
      require("lazydev").setup({
        integrations = {
          cmp = false,
        },
        library = lib_dir and {
          { path = lib_dir, words = { "vim%.uv" } },
        } or {},
      })
    end,
  },
  {
    "nvim-lspconfig",
    on_require = { "lspconfig" },
    dep_of = { "typescript-tools.nvim" },
    after = function()
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
    end,
    lsp = function(plugin)
      vim.lsp.config(plugin.name, plugin.lsp or {})
      vim.lsp.enable(plugin.name)
    end,
  },
  {
    "fidget.nvim",
    event = "LspAttach",
    after = function()
      require("fidget").setup({})
    end,
  },
  {
    "typescript-tools.nvim",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    after = function()
      require("typescript-tools").setup({})
    end,
  },
  { "ty", lsp = {} },
  { "rust_analyzer", lsp = {} },
  { "jsonls", lsp = {} },
  { "html", lsp = {} },
  { "eslint", lsp = {} },
  { "cssls", lsp = {} },
  { "tailwindcss", lsp = {} },
  { "nushell", lsp = {} },
  { "nixd", lsp = {} },
  {
    "lua_ls",
    lsp = {
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    },
  },
}
