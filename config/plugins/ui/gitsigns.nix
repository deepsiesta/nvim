{
  plugins.gitsigns = {
    enable = true;
    settings = {
      signs = {
        add = {text = "+";};
        change = {text = "~";};
        delete = {text = "_";};
        topdelete = {text = "‾";};
        changedelete = {text = "~";};
      };
    };
  };

  keymaps = [
    # Navigation
    {
      mode = "n";
      key = "]h";
      action = "<cmd>Gitsigns next_hunk<CR>";
      options.desc = "Next Git [H]unk";
    }
    {
      mode = "n";
      key = "[h";
      action = "<cmd>Gitsigns prev_hunk<CR>";
      options.desc = "Prev Git [H]unk";
    }

    # Actions
    {
      mode = "n";
      key = "<leader>hs";
      action = "<cmd>Gitsigns stage_hunk<CR>";
      options.desc = "git [s]tage hunk";
    }
    {
      mode = "n";
      key = "<leader>hr";
      action = "<cmd>Gitsigns reset_hunk<CR>";
      options.desc = "git [r]eset hunk";
    }
    {
      mode = "v";
      key = "<leader>hs";
      action = "<cmd>Gitsigns stage_hunk<CR>";
      options.desc = "stage git hunk";
    }
    {
      mode = "v";
      key = "<leader>hr";
      action = "<cmd>Gitsigns reset_hunk<CR>";
      options.desc = "reset git hunk";
    }
    {
      mode = "n";
      key = "<leader>hS";
      action = "<cmd>Gitsigns stage_buffer<CR>";
      options.desc = "git [S]tage buffer";
    }
    {
      mode = "n";
      key = "<leader>hu";
      action = "<cmd>Gitsigns undo_stage_hunk<CR>";
      options.desc = "git [u]ndo stage hunk";
    }
    {
      mode = "n";
      key = "<leader>hR";
      action = "<cmd>Gitsigns reset_buffer<CR>";
      options.desc = "git [R]eset buffer";
    }
    {
      mode = "n";
      key = "<leader>hp";
      action = "<cmd>Gitsigns preview_hunk<CR>";
      options.desc = "git [p]review hunk";
    }
    {
      mode = "n";
      key = "<leader>hb";
      action = "<cmd>Gitsigns blame_line<CR>";
      options.desc = "git [b]lame line";
    }
    {
      mode = "n";
      key = "<leader>hd";
      action = "<cmd>Gitsigns diffthis<CR>";
      options.desc = "git [d]iff against index";
    }
    {
      mode = "n";
      key = "<leader>hD";
      action = "<cmd>lua require('gitsigns').diffthis('~')<CR>";
      options.desc = "git [D]iff against last commit";
    }

    # Toggles
    {
      mode = "n";
      key = "<leader>tb";
      action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
      options.desc = "[T]oggle git show [b]lame line";
    }
    {
      mode = "n";
      key = "<leader>td";
      action = "<cmd>Gitsigns toggle_deleted<CR>";
      options.desc = "[T]oggle git show [d]eleted";
    }
  ];
}
