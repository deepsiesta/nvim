{
  plugins.mini = {
    enable = true;
    modules = {
      ai = {
        n_lines = 500;
      };
      surround = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
      };
      pairs = {
        skip_next = "[=[[%w%%%'%[%\\\" ]]=]";
        skip_ts = ["string"];
        skip_unbalanced = true;
        markdown = true;
      };
      comment = {
        options = {
          custom_commentstring.__raw =
            # Lua
            ''
              function()
                return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
              end
            '';
        };
      };
    };
  };

  # Context aware commenting, pairs well with mini.comment
  plugins.ts-context-commentstring = {
    enable = true;
    disableAutoInitialization = true;
  };
}
