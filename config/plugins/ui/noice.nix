{
  plugins.noice = {
    enable = true;
    settings = {
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
      };
      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
        inc_rename = false;
        lsp_doc_border = false;
      };
      routes = [
        {
          filter = {
            event = "msg_show";
            any = [
              {find = "%d+L, %d+B";}
              {find = "; after #%d+";}
              {find = "; before #%d+";}
            ];
          };
          view = "mini";
        }
      ];
    };
  };

  # Noice requires notify if not using snacks, but since we are using snacks.notifier,
  # noice automatically integrates with it in modern versions. However, we ensure
  # nvim-notify is disabled so it doesn't conflict.
  plugins.notify.enable = false;
}
