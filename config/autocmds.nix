{
  autoGroups = {
    kickstart-highlight-yank = {clear = true;};
  };

  autoCmd = [
    {
      event = ["TextYankPost"];
      desc = "Highlight when yanking (copying) text";
      group = "kickstart-highlight-yank";
      callback.__raw = "vim.highlight.on_yank";
    }
    {
      event = "VimEnter";
      desc = "Remove cursor highlight background and set indent guide color";
      callback.__raw = ''
        function()
          vim.cmd("highlight CursorLine guibg=NONE")
          vim.cmd("highlight! link SnacksIndent NonText")
        end
      '';
    }
  ];
}
