return {
  "nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  after = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      nix = { "nix" },
      markdown = { "markdownlint" },
    }

    lint.linters.markdownlint.args = {
      "--stdin",
      "--disable",
      "MD013",
    }

    local efm_parser = require("lint.parser").from_errorformat("stdin:%l:%c %m,stdin:%l %m")

    -- Make MD040 errors visible
    -- MD040 (code blocks should have a language id) flags on the opening triple backticks
    -- This is hidden by `conceallevel=2`, so we move the warning one line down
    lint.linters.markdownlint.parser = function(output, bufnr)
      local diagnostics = efm_parser(output, bufnr)

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

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })

    lint.try_lint()
  end,
}
