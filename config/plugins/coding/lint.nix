{pkgs, ...}: {
  plugins.lint = {
    enable = true;

    lintersByFt = {
      nix = ["nix"];
      markdown = ["markdownlint"];
    };

    autoCmd = {
      callback.__raw =
        # Lua
        ''
          function()
            require('lint').try_lint()
          end
        '';
      event = [
        "BufEnter"
        "BufWritePost"
        "InsertLeave"
      ];
    };
  };

  extraPackages = with pkgs; [
    nodePackages.markdownlint-cli
  ];
}
