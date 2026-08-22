return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters.oxlint = {
      cmd = "oxlint",
      stdin = false,
      args = {
        "--format", "json",
        "--tsconfig", "./tsconfig.json",
      },
      append_fname = true,
      stream = "stdout",
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local diagnostics = {}
        local ok, result = pcall(vim.json.decode, output)
        if not ok or type(result) ~= "table" then
          return diagnostics
        end

        for _, file in ipairs(result) do
          if type(file.messages) == "table" then
            for _, msg in ipairs(file.messages) do
              local severity = vim.diagnostic.severity.WARN
              if msg.severity == 2 then
                severity = vim.diagnostic.severity.ERROR
              elseif msg.severity == 1 then
                severity = vim.diagnostic.severity.WARN
              end

              table.insert(diagnostics, {
                lnum = (msg.line or 1) - 1,
                col = (msg.column or 1) - 1,
                end_lnum = (msg.endLine or msg.line or 1) - 1,
                end_col = (msg.endColumn or msg.column or 1) - 1,
                message = msg.message or "",
                severity = severity,
                source = "oxlint",
                code = msg.ruleId,
              })
            end
          end
        end

        return diagnostics
      end,
    }

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
