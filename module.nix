{
  wlib,
  pkgs,
  ...
}: {
  imports = [wlib.wrapperModules.neovim];

  settings.config_directory = ./config;

  hosts = {
    node.nvim-host.enable = false;
    perl.nvim-host.enable = false;
  };

  specs = {
    core = with pkgs.vimPlugins; [
      lze
      lzextras
      tokyonight-nvim
      nvim-web-devicons
      snacks-nvim
      noice-nvim
      lualine-nvim
      nvim-treesitter.withAllGrammars
      vim-sleuth
    ];

    lazy = {
      lazy = true;
      pluginDeps = "lazy";
      data = with pkgs.vimPlugins; [
        # UI
        which-key-nvim
        gitsigns-nvim
        render-markdown-nvim

        # Coding
        blink-cmp
        friendly-snippets
        nvim-lint
        mini-nvim
        nvim-ts-context-commentstring
        nvim-treesitter-textobjects
        nvim-ts-autotag
        todo-comments-nvim
        vim-nix
        nix-develop-nvim
        vimtex

        # LSP & Formatting
        nvim-lspconfig
        fidget-nvim
        typescript-tools-nvim
        lazydev-nvim
        luvit-meta
        conform-nvim
      ];
    };
  };

  runtimePkgs = with pkgs; [
    # Clipboard & core deps
    wl-clipboard
    fd
    ripgrep
    git
    lazygit
    jq

    # Nix
    nixd
    alejandra

    # Lua
    lua-language-server
    stylua

    # Rust
    cargo
    rustc
    rust-analyzer
    rustfmt

    # Python
    ty
    ruff

    # JS/TS & Web
    nodejs
    typescript
    vscode-langservers-extracted
    tailwindcss-language-server
    prettierd

    # Nushell
    nushell

    # Markdown
    markdownlint-cli
    python3Packages.pylatexenc

    # LaTeX
    pstree
    xdotool
    texliveSmall
    texlivePackages.latexmk
    texlivePackages.latexindent
  ];
}
