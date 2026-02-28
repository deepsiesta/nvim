{
  plugins.snacks = {
    enable = true;
    settings = {
      bigfile.enabled = true;
      bufdelete.enabled = true;
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
      gitbrowse.enabled = true;
      input.enabled = true;
      lazygit.enabled = true;
      notifier.enabled = true;
      picker.enabled = true;
      rename.enabled = true;
      scope.enabled = true;
      scratch.enabled = true;
      statuscolumn.enabled = true;
      terminal.enabled = true;
      toggle.enabled = true;
      words.enabled = true;
      zen.enabled = true;
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
          enabled = false;
        };
      };
    };
  };

  keymaps = [
    # Top level
    {
      mode = "n";
      key = "<leader><leader>";
      action = "<cmd>lua Snacks.picker.buffers()<CR>";
      options.desc = "Find existing buffers";
    }
    {
      mode = "n";
      key = "<leader>/";
      action = "<cmd>lua Snacks.picker.grep_buffers()<CR>";
      options.desc = "[/] Fuzzily search in open buffers";
    }
    {
      mode = "n";
      key = "<leader>.";
      action = "<cmd>lua Snacks.scratch()<CR>";
      options.desc = "Toggle Scratch Buffer";
    }
    {
      mode = "n";
      key = "<leader>S";
      action = "<cmd>lua Snacks.scratch.select()<CR>";
      options.desc = "Select Scratch Buffer";
    }

    # [S]earch
    {
      mode = "n";
      key = "<leader>sh";
      action = "<cmd>lua Snacks.picker.help()<CR>";
      options.desc = "[S]earch [H]elp";
    }
    {
      mode = "n";
      key = "<leader>sk";
      action = "<cmd>lua Snacks.picker.keymaps()<CR>";
      options.desc = "[S]earch [K]eymaps";
    }
    {
      mode = "n";
      key = "<leader>sf";
      action = "<cmd>lua Snacks.picker.files()<CR>";
      options.desc = "[S]earch [F]iles";
    }
    {
      mode = "n";
      key = "<leader>ss";
      action = "<cmd>lua Snacks.picker.pickers()<CR>";
      options.desc = "[S]earch [S]elect Picker";
    }
    {
      mode = "n";
      key = "<leader>sw";
      action = "<cmd>lua Snacks.picker.grep_word()<CR>";
      options.desc = "[S]earch current [W]ord";
    }
    {
      mode = "n";
      key = "<leader>sg";
      action = "<cmd>lua Snacks.picker.grep()<CR>";
      options.desc = "[S]earch by [G]rep";
    }
    {
      mode = "n";
      key = "<leader>sd";
      action = "<cmd>lua Snacks.picker.diagnostics()<CR>";
      options.desc = "[S]earch [D]iagnostics";
    }
    {
      mode = "n";
      key = "<leader>sr";
      action = "<cmd>lua Snacks.picker.resume()<CR>";
      options.desc = "[S]earch [R]esume";
    }
    {
      mode = "n";
      key = "<leader>sq";
      action = "<cmd>lua Snacks.picker.qflist()<CR>";
      options.desc = "[S]earch [Q]uickfix List";
    }
    {
      mode = "n";
      key = "<leader>s.";
      action = "<cmd>lua Snacks.picker.recent()<CR>";
      options.desc = "[S]earch Recent Files ('.' for repeat)";
    }
    {
      mode = "n";
      key = "<leader>sn";
      action = "<cmd>lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })<CR>";
      options.desc = "[S]earch [N]eovim files";
    }

    # [G]it
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>lua Snacks.lazygit()<CR>";
      options.desc = "Lazygit";
    }
    {
      mode = "n";
      key = "\\";
      action = "<cmd>lua Snacks.explorer.reveal()<CR>";
      options.desc = "Explorer Reveal";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "<cmd>lua Snacks.git.blame_line()<CR>";
      options.desc = "Git Blame Line";
    }
    {
      mode = "n";
      key = "<leader>gB";
      action = "<cmd>lua Snacks.gitbrowse()<CR>";
      options.desc = "Git Browse";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action = "<cmd>lua Snacks.lazygit.log()<CR>";
      options.desc = "Lazygit Log (cwd)";
    }
    {
      mode = "n";
      key = "<leader>gf";
      action = "<cmd>lua Snacks.lazygit.log_file()<CR>";
      options.desc = "Lazygit Current File History";
    }

    # UI/UX
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>lua Snacks.explorer()<CR>";
      options.desc = "Explorer";
    }
    {
      mode = "n";
      key = "<leader>n";
      action = "<cmd>lua Snacks.notifier.show_history()<CR>";
      options.desc = "Notification History";
    }
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>lua Snacks.bufdelete()<CR>";
      options.desc = "Delete Buffer";
    }
    {
      mode = "n";
      key = "<leader>cR";
      action = "<cmd>lua Snacks.rename.rename_file()<CR>";
      options.desc = "Rename File";
    }
    {
      mode = "n";
      key = "<leader>un";
      action = "<cmd>lua Snacks.notifier.hide()<CR>";
      options.desc = "Dismiss All Notifications";
    }
    {
      mode = "n";
      key = "<leader>z";
      action = "<cmd>lua Snacks.zen()<CR>";
      options.desc = "Toggle Zen Mode";
    }
    {
      mode = "n";
      key = "<leader>Z";
      action = "<cmd>lua Snacks.zen.zoom()<CR>";
      options.desc = "Toggle Zoom";
    }

    # Toggles
    {
      mode = "n";
      key = "<leader>ub";
      action = "<cmd>lua Snacks.toggle.backbackground():toggle()<CR>";
      options.desc = "Toggle Background";
    }
    {
      mode = "n";
      key = "<leader>uf";
      action = "<cmd>lua Snacks.toggle.format():toggle()<CR>";
      options.desc = "Toggle Auto Format";
    }
    {
      mode = "n";
      key = "<leader>ul";
      action = "<cmd>lua Snacks.toggle.line_number():toggle()<CR>";
      options.desc = "Toggle Line Numbers";
    }
    {
      mode = "n";
      key = "<leader>ui";
      action = "<cmd>lua Snacks.toggle.indent():toggle()<CR>";
      options.desc = "Toggle Indent Guides";
    }
    {
      mode = "n";
      key = "<leader>us";
      action = "<cmd>lua Snacks.toggle.scroll():toggle()<CR>";
      options.desc = "Toggle Smooth Scroll";
    }
    {
      mode = "n";
      key = "<leader>uw";
      action = "<cmd>lua Snacks.toggle.wrap():toggle()<CR>";
      options.desc = "Toggle Wrap";
    }
  ];
}
