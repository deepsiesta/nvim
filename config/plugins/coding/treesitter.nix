{
  plugins.treesitter = {
    enable = true;
    settings = {
      highlight = {
        enable = true;
        additional_vim_regex_highlighting = false;
      };
      indent.enable = true;
      incremental_selection = {
        enable = true;
        keymaps = {
          init_selection = "<C-space>";
          node_incremental = "<C-space>";
          scope_incremental = false;
          node_decremental = "<bs>";
        };
      };
    };
  };

  plugins.treesitter-textobjects = {
    enable = true;
    settings = {
      select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
        };
      };
    };
  };

  plugins.ts-autotag.enable = true;
}
