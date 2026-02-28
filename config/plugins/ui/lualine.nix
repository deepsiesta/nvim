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
          {
            __unkeyed-1.__raw =
              # Lua
              ''
                function()
                  return require("noice").api.status.command.get()
                end
              '';
            cond.__raw =
              # Lua
              ''
                function()
                  return package.loaded["noice"] and require("noice").api.status.command.has()
                end
              '';
            color = {fg = "#ff9e64";};
          }
        ];
        lualine_y = ["encoding" "fileformat" "filetype"];
        lualine_z = ["location"];
      };
    };
  };
}
