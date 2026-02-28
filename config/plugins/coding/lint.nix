{pkgs, ...}: {
  plugins.lint = {
    enable = true;

    lintersByFt = {
      nix = ["nix"];
      markdown = ["markdownlint"];
    };
  };

  autoGroups = {
    lint = {
      clear = true;
    };
  };

  autoCmd = [
    {
      callback.__raw =
        # Lua
        ''
          function()
            require('lint').try_lint()
          end
        '';
      group = "lint";
      event = [
        "BufEnter"
        "BufWritePost"
        "InsertLeave"
      ];
    }
  ];

  extraPackages = with pkgs; [
    nodePackages.markdownlint-cli
  ];
}
