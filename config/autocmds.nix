{
  autoGroups = {
    highlight-yank = {clear = true;};
  };

  autoCmd = [
    {
      event = ["TextYankPost"];
      desc = "Highlight when yanking (copying) text";
      group = "highlight-yank";
      callback.__raw = "vim.highlight.on_yank";
    }
    {
      event = "VimEnter";
      desc = "Remove cursor highlight background and set indent guide color";
      command = "highlight CursorLine guibg=NONE | highlight! link SnacksIndent NonText";
    }
  ];
}
