{
  plugins.neorg = {
    enable = true;
    settings = {
      load = {
        "core.defaults" = {
          __empty = {};
        };
        "core.concealer" = {
          __empty = {};
        };
        "core.dirman" = {
          config = {
            workspaces = {
              notes = "~/notes";
            };
            default_workspace = "notes";
          };
        };
        "core.export" = {
          __empty = {};
        };
        "core.summary" = {
          __empty = {};
        };
        "core.journal" = {
          config = {
            strategy = "nested";
            workspace = "notes";
          };
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>Ni";
      action = "<cmd>Neorg index<CR>";
      options.desc = "Neorg Index";
    }
    {
      mode = "n";
      key = "<leader>Nj";
      action = "<cmd>Neorg journal today<CR>";
      options.desc = "Journal Today";
    }
    {
      mode = "n";
      key = "<leader>Nw";
      action = "<cmd>Neorg workspace<CR>";
      options.desc = "Select Workspace";
    }
    {
      mode = "n";
      key = "<leader>Ns";
      action = "<cmd>Neorg generate-workspace-summary<CR>";
      options.desc = "Generate Workspace Summary";
    }
    {
      mode = "n";
      key = "<leader>Nc";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Capture: " }, function(input)
            if input ~= nil and input ~= "" then
              local file = vim.fn.expand("~/notes/inbox.norg")
              local f = io.open(file, "a")
              if f then
                f:write("\n* " .. os.date("%Y-%m-%d %H:%M") .. "\n  " .. input .. "\n")
                f:close()
                print("Captured to inbox.norg")
              else
                print("Error: Could not open inbox.norg")
              end
            end
          end)
        end
      '';
      options.desc = "Capture to inbox.norg";
    }
    {
      mode = "n";
      key = "<leader>Nn";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = "New note title: " }, function(input)
            if input ~= nil and input ~= "" then
              vim.cmd("edit ~/notes/" .. input .. ".norg")
            end
          end)
        end
      '';
      options.desc = "New Note";
    }
  ];
}
