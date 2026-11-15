{
  description = "A nix-wrapper-modules neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    wrappers = {
      url = "github:nix-community/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    wrappers,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.treefmt-nix.flakeModule
        wrappers.flakeModules.wrappers
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      flake.wrappers = {
        neovim = ./module.nix;
        default = ./module.nix;
      };

      perSystem = {
        config,
        pkgs,
        ...
      }: let
        nvim = config.packages.default;
      in {
        treefmt.config = {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
          programs.deadnix.enable = true;
          programs.statix.enable = true;
          programs.stylua.enable = true;
        };

        formatter = config.treefmt.build.wrapper;

        checks = let
          checkScript =
            # lua
            ''
              if vim.v.errmsg ~= "" then
                io.stderr:write("Vim error: " .. vim.v.errmsg .. "\n")
                os.exit(1)
              end
              local eager_modules = {
                "lze",
                "lzextras",
                "tokyonight",
                "nvim-web-devicons",
                "snacks",
                "noice",
                "lualine",
                "nvim-treesitter",
              }
              for _, mod in ipairs(eager_modules) do
                local ok, err = pcall(require, mod)
                if not ok then
                  io.stderr:write("Failed to require eager module " .. mod .. ": " .. tostring(err) .. "\n")
                  os.exit(1)
                end
              end

              local lazy_plugins = {
                { "which-key.nvim", "which-key" },
                { "gitsigns.nvim", "gitsigns" },
                { "render-markdown.nvim", "render-markdown" },
                { "blink.cmp", "blink.cmp" },
                { "nvim-lint", "lint" },
                { "mini.nvim", "mini.ai" },
                { "nvim-ts-context-commentstring", "ts_context_commentstring" },
                { "nvim-treesitter-textobjects", "nvim-treesitter-textobjects" },
                { "nvim-ts-autotag", "nvim-ts-autotag" },
                { "todo-comments.nvim", "todo-comments" },
                { "nvim-lspconfig", "lspconfig" },
                { "fidget.nvim", "fidget" },
                { "typescript-tools.nvim", "typescript-tools" },
                { "conform.nvim", "conform" },
              }
              local orig_notify = vim.notify
              local notify_errors = {}
              vim.notify = function(msg, level, opts)
                if level == vim.log.levels.ERROR then
                  table.insert(notify_errors, tostring(msg))
                end
                return orig_notify(msg, level, opts)
              end
              local lze = require("lze")
              for _, entry in ipairs(lazy_plugins) do
                local plugin_name, mod = entry[1], entry[2]
                lze.trigger_load(plugin_name)
                local ok, err = pcall(require, mod)
                if not ok then
                  io.stderr:write("Failed to load lazy module " .. mod .. " (" .. plugin_name .. "): " .. tostring(err) .. "\n")
                  os.exit(1)
                end
              end
              local flushed = false
              vim.schedule(function()
                flushed = true
              end)
              vim.wait(1000, function()
                return flushed
              end)
              if #notify_errors > 0 then
                io.stderr:write("Notification errors:\n" .. table.concat(notify_errors, "\n") .. "\n")
                os.exit(1)
              end
              os.exit(0)
            '';
        in {
          neovim =
            pkgs.runCommand "neovim-check" {}
            # bash
            ''
              export HOME=$(mktemp -d)
              ${nvim}/bin/nvim --headless -c "luafile ${pkgs.writeText "neovim-check.lua" checkScript}"
              touch "$out"
            '';
        };

        devShells.default = pkgs.mkShell {
          packages = [
            nvim
          ];
        };
      };
    };
}
