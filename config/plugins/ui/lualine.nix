{
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = "tokyonight";
        globalstatus = true;
        component_separators = {
          left = "│";
          right = "│";
        };
        section_separators = {
          left = "";
          right = "";
        };
      };
      sections = {
        lualine_a = ["mode"];
        lualine_b = ["branch" "diff" "diagnostics"];
        lualine_c = [
          {
            __unkeyed-1 = "filename";
            path = 1; # relative path
          }
        ];
        lualine_x = [
          # Noice status components
          {
            __unkeyed-1 = "noice_command";
            color = {fg = "#ff9e64";};
          }
          {
            __unkeyed-1 = "noice_mode";
            color = {fg = "#ff9e64";};
          }
          "encoding"
          "fileformat"
          "filetype"
        ];
        lualine_y = ["progress"];
        lualine_z = ["location"];
      };
    };
  };
}
