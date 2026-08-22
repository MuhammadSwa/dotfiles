return {
  "mfussenegger/nvim-lint",
  -- Deferred: lint autocmds (BufEnter/BufWritePost/InsertLeave) take over once loaded
  event = "VeryLazy",
  config = function()
    local lint = require("lint")

    lint.linters.blueprint_lint = {
      cmd = "blueprint-compiler",
      stdin = false,
      append_fname = true,
      stream = "stdout",
      ignore_exitcode = true,
      parser = function(output, _)
        local diagnostics = {}
        local cur = nil

        local function strip_ansi(s)
          s = s:gsub("\27%]8;[^\27]*\27\\", "")
          s = s:gsub("\27%[[0-9;]*m", "")
          return s
        end

        for _, raw in ipairs(vim.split(output, "\n")) do
          local line = strip_ansi(raw)
          local sev, msg, rule = line:match("^(%a+): (.-)%s*%[(.+)%]$")
          if sev then
            if cur then
              table.insert(diagnostics, cur)
            end
            cur = {
              message = msg,
              severity = sev == "error" and vim.diagnostic.severity.ERROR
                or sev == "warning" and vim.diagnostic.severity.WARN
                or vim.diagnostic.severity.HINT,
              code = rule,
            }
          else
            local lnum, col = line:match("^at .+ line (%d+) column (%d+):$")
            if cur and lnum then
              cur.lnum = tonumber(lnum) - 1
              cur.col = math.max(tonumber(col) - 1, 0)
            elseif cur and cur.lnum then
              local carets = line:match("^%s*|%^(%^+)")
              if carets then
                cur.end_lnum = cur.lnum
                cur.end_col = cur.col + #carets
              end
            end
          end
        end
        if cur then
          table.insert(diagnostics, cur)
        end

        return diagnostics
      end,
    }

    lint.linters_by_ft = {
      javascript = { "oxlint" },
      typescript = { "oxlint" },
      javascriptreact = { "oxlint" },
      typescriptreact = { "oxlint" },
      blueprint = { "blueprint_lint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("Lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
