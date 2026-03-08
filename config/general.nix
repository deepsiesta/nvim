{
  clipboard = {
    register = "unnamedplus";
    providers = {
      wl-copy.enable = true;
      xsel.enable = true;
    };
  };

  opts = {
    number = true;
    relativenumber = true;
    mouse = "a";
    showmode = false;

    breakindent = true;
    undofile = true;
    ignorecase = true;
    smartcase = true;
    signcolumn = "yes";
    updatetime = 250;
    timeoutlen = 300;

    # Indentation
    tabstop = 2;
    shiftwidth = 2;
    softtabstop = 2;
    expandtab = true;
    smartindent = true;

    splitright = true;
    splitbelow = true;

    list = true;
    listchars = {
      tab = "» ";
      trail = "·";
      nbsp = "␣";
    };

    inccommand = "split";
    cursorline = true;
    scrolloff = 10;
    hlsearch = true;
    conceallevel = 0;
  };

  globals = {
    mapleader = " ";
    maplocalleader = " ";
    have_nerd_font = true;
  };
}
