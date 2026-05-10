{pkgs, ...}: {
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
        python = ["ruff_format"];
        javascript = ["prettierd"];
        typescript = ["prettierd"];
        javascriptreact = ["prettierd"];
        typescriptreact = ["prettierd"];
        css = ["prettierd"];
        html = ["prettierd"];
        json = ["jq"];
        yaml = ["prettierd"];
        markdown = ["markdownlint"];
        latex = ["latexindent"];
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

  extraPackages = with pkgs; [
    stylua
    jq
    alejandra
    prettierd
    rustfmt
    ruff
    texlivePackages.latexindent
    markdownlint-cli
  ];
}
