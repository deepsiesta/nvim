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
      event = "FileType";
      pattern = "norg";
      command = "setlocal conceallevel=2";
      desc = "Enable concealing for Neorg files";
    }
    {
      event = "VimEnter";
      desc = "Remove cursor highlight background and set indent guide color";
      command = "highlight CursorLine guibg=NONE | highlight! link SnacksIndent NonText";
    }
  ];
}
