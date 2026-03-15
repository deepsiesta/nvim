{pkgs, ...}: {
  plugins.render-markdown = {
    enable = true;
    settings = {
      win_options.conceallevel = {
        default = 2;
        rendered = 2;
      };

      anti_conceal.enabled = true;
      only_render_image_at_cursor = true;
      pipe_table.style = "full";

      sign = {
        enabled = true;
      };

      heading = {
        enabled = true;
        sign = true;
        icons = ["󰲡 " "󰲣 " "󰲥 " "󰲧 " "󰲩 " "󰲫 "];
      };

      checkbox = {
        enabled = true;
        unchecked = {icon = "󰄱 ";};
        checked = {icon = "󰄵 ";};
      };

      quote = {
        enabled = true;
        icon = "▋";
        repeat_linebreak = false;
      };

      code = {
        enabled = true;
        sign = false;
        style = "full";
        width = "block";
        left_pad = 2;
        right_pad = 2;
      };

      bullet = {
        enabled = true;
        icons = ["●" "○" "◆" "◇"];
      };

      latex = {
        enabled = true;
        converter = "latex2text";
      };
    };
  };

  extraPackages = with pkgs; [
    python313Packages.pylatexenc
  ];
}
