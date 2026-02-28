{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lsp_fallback = false;
        timeout_ms = 1000;
      };
      notify_on_error = false;
      formatters_by_ft = {
        lua = ["stylua"];
        nix = ["alejandra"];
        rust = ["rustfmt"];
        javascript = ["prettierd" "prettier"];
        typescript = ["prettierd" "prettier"];
        javascriptreact = ["prettierd" "prettier"];
        typescriptreact = ["prettierd" "prettier"];
        css = ["prettierd" "prettier"];
        html = ["prettierd" "prettier"];
        json = ["prettierd" "prettier"];
        yaml = ["prettierd" "prettier"];
        markdown = ["prettierd" "prettier"];
      };
    };
  };

  keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>cf";
      action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>";
      options.desc = "Format buffer";
    }
  ];
}
