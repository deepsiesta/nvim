{pkgs, ...}: {
  plugins.lint = {
    enable = true;

    lintersByFt = {
      nix = ["nix"];
      markdown = ["markdownlint"];
    };

    linters = {
      markdownlint = {
        args = [
          "--stdin"
          "--disable"
          "MD013"
        ];
        # Make MD040 errors visible
        # MD040 (code blocks should have a language id) flags on the opening triple backticks
        # This is hidden by `conceallevel=2`, so we move the warning one line down
        parser.__raw =
          # lua
          ''
            function(output, bufnr)
              local parser = require('lint.parser').from_errorformat("stdin:%l:%c %m,stdin:%l %m")
              local diagnostics = parser(output, bufnr)

              for _, diag in ipairs(diagnostics) do
                if diag.message:find("MD040") then
                  local line_count = vim.api.nvim_buf_line_count(bufnr)
                  local next_line = vim.api.nvim_buf_get_lines(bufnr, diag.lnum + 1, diag.lnum + 2, false)[1]

                  if next_line and next_line:find("^%s*```") then
                    -- Empty code block: shift to the line after the closing backticks
                    diag.lnum = math.min(diag.lnum + 2, line_count - 1)
                  else
                    -- Normal code block: shift to the first line inside the block
                    diag.lnum = math.min(diag.lnum + 1, line_count - 1)
                  end

                  if diag.end_lnum then
                    diag.end_lnum = diag.lnum
                  end
                  diag.severity = vim.diagnostic.severity.WARN
                end
              end

              return diagnostics
            end
          '';
      };
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
