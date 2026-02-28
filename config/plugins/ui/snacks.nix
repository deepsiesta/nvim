{
  plugins.snacks = {
    enable = true;
    settings = {
      dashboard = {
        enable = true;
        preset = {
          header = ''
            ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
            ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
            ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
            ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
            ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
            ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
          '';
          keys = [
            {
              icon = " ";
              key = "f";
              desc = "Find File";
              action = ":lua Snacks.dashboard.pick('files')";
            }
            {
              icon = " ";
              key = "n";
              desc = "New File";
              action = ":ene | startinsert";
            }
            {
              icon = " ";
              key = "g";
              desc = "Find Text";
              action = ":lua Snacks.dashboard.pick('live_grep')";
            }
            {
              icon = " ";
              key = "r";
              desc = "Recent Files";
              action = ":lua Snacks.dashboard.pick('oldfiles')";
            }
            {
              icon = " ";
              key = "c";
              desc = "Config";
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})";
            }
            {
              icon = " ";
              key = "s";
              desc = "Restore Session";
              section = "session";
            }
            {
              icon = " ";
              key = "q";
              desc = "Quit";
              action = ":qa";
            }
          ];
        };
      };
      explorer.enabled = true;
      picker.enabled = true;
      indent = {
        enabled = true;
        indent = {
          priority = 1;
          enabled = true;
          char = "▎";
        };
        scope = {
          enabled = true;
          priority = 200;
          char = "▎";
        };
        chunk = {
          enabled = false;
        };
        animate = {
          enabled = false; # Disable animation to ensure guides are static and correct
        };
      };
      notifier.enabled = true;
      statuscolumn.enabled = true;
      words.enabled = true;
    };
  };

  keymaps = [
    # Top level
    {
      mode = "n";
      key = "<leader><leader>";
      action.__raw = "function() Snacks.picker.buffers() end";
      options.desc = "Find existing buffers";
    }
    {
      mode = "n";
      key = "<leader>/";
      action.__raw = "function() Snacks.picker.grep_buffers() end";
      options.desc = "[/] Fuzzily search in open buffers";
    }

    # [S]earch
    {
      mode = "n";
      key = "<leader>sh";
      action.__raw = "function() Snacks.picker.help() end";
      options.desc = "[S]earch [H]elp";
    }
    {
      mode = "n";
      key = "<leader>sk";
      action.__raw = "function() Snacks.picker.keymaps() end";
      options.desc = "[S]earch [K]eymaps";
    }
    {
      mode = "n";
      key = "<leader>sf";
      action.__raw = "function() Snacks.picker.files() end";
      options.desc = "[S]earch [F]iles";
    }
    {
      mode = "n";
      key = "<leader>ss";
      action.__raw = "function() Snacks.picker.pickers() end";
      options.desc = "[S]earch [S]elect Picker";
    }
    {
      mode = "n";
      key = "<leader>sw";
      action.__raw = "function() Snacks.picker.grep_word() end";
      options.desc = "[S]earch current [W]ord";
    }
    {
      mode = "n";
      key = "<leader>sg";
      action.__raw = "function() Snacks.picker.grep() end";
      options.desc = "[S]earch by [G]rep";
    }
    {
      mode = "n";
      key = "<leader>sd";
      action.__raw = "function() Snacks.picker.diagnostics() end";
      options.desc = "[S]earch [D]iagnostics";
    }
    {
      mode = "n";
      key = "<leader>sr";
      action.__raw = "function() Snacks.picker.resume() end";
      options.desc = "[S]earch [R]esume";
    }
    {
      mode = "n";
      key = "<leader>sq";
      action.__raw = "function() Snacks.picker.qflist() end";
      options.desc = "[S]earch [Q]uickfix List";
    }
    {
      mode = "n";
      key = "<leader>s.";
      action.__raw = "function() Snacks.picker.recent() end";
      options.desc = "[S]earch Recent Files ('.' for repeat)";
    }
    {
      mode = "n";
      key = "<leader>sn";
      action.__raw = "function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end";
      options.desc = "[S]earch [N]eovim files";
    }

    # [G]it
    {
      mode = "n";
      key = "<leader>gg";
      action.__raw = "function() Snacks.lazygit() end";
      options.desc = "Lazygit";
    }
    {
      mode = "n";
      key = "\\";
      action.__raw = "function() Snacks.explorer.reveal() end";
      options.desc = "Explorer Reveal";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action.__raw = "function() Snacks.git.blame_line() end";
      options.desc = "Git Blame Line";
    }
    {
      mode = "n";
      key = "<leader>gB";
      action.__raw = "function() Snacks.gitbrowse() end";
      options.desc = "Git Browse";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action.__raw = "function() Snacks.lazygit.log() end";
      options.desc = "Lazygit Log (cwd)";
    }
    {
      mode = "n";
      key = "<leader>gf";
      action.__raw = "function() Snacks.lazygit.log_file() end";
      options.desc = "Lazygit Current File History";
    }

    # UI/UX
    {
      mode = "n";
      key = "<leader>e";
      action.__raw = "function() Snacks.explorer() end";
      options.desc = "Explorer";
    }
    {
      mode = "n";
      key = "<leader>n";
      action.__raw = "function() Snacks.notifier.show_history() end";
      options.desc = "Notification History";
    }
    {
      mode = "n";
      key = "<leader>bd";
      action.__raw = "function() Snacks.bufdelete() end";
      options.desc = "Delete Buffer";
    }
    {
      mode = "n";
      key = "<leader>cR";
      action.__raw = "function() Snacks.rename.rename_file() end";
      options.desc = "Rename File";
    }
    {
      mode = "n";
      key = "<leader>un";
      action.__raw = "function() Snacks.notifier.hide() end";
      options.desc = "Dismiss All Notifications";
    }
  ];
}
