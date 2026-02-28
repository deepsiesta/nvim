{
  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "enter";
        "<Tab>" = ["select_next" "fallback"];
        "<S-Tab>" = ["select_prev" "fallback"];
      };

      completion = {
        accept.auto_brackets.enabled = true;
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
        };
        menu.draw.treesitter = ["lsp"];
      };

      sources = {
        default = ["lsp" "path" "snippets" "buffer"];
        providers = {
          lsp.score_offset = 3;
          snippets.score_offset = 2;
          path.score_offset = 1;
          buffer.score_offset = 0;
        };
      };

      signature = {
        enabled = true;
      };
    };
  };

  plugins.friendly-snippets.enable = true;
}
