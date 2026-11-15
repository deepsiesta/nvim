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

        checks = {
          neovim = pkgs.runCommand "neovim-check" {} ''
            export HOME=$(mktemp -d)
            ${nvim}/bin/nvim --headless -c 'lua
              if vim.v.errmsg ~= "" then
                io.stderr:write("Vim error: " .. vim.v.errmsg .. "\n")
                os.exit(1)
              end
              local required_modules = {
                "tokyonight",
                "nvim-web-devicons",
                "snacks",
                "noice",
                "lualine",
                "which-key",
                "gitsigns",
                "render-markdown",
                "blink.cmp",
                "lint",
                "mini.ai",
                "mini.surround",
                "mini.pairs",
                "mini.comment",
                "ts_context_commentstring",
                "nvim-treesitter",
                "nvim-treesitter-textobjects",
                "nvim-ts-autotag",
                "todo-comments",
                "lspconfig",
                "fidget",
                "typescript-tools",
                "conform",
              }
              for _, mod in ipairs(required_modules) do
                local ok, err = pcall(require, mod)
                if not ok then
                  io.stderr:write("Failed to require " .. mod .. ": " .. tostring(err) .. "\n")
                  os.exit(1)
                end
              end
              os.exit(0)
            '
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
