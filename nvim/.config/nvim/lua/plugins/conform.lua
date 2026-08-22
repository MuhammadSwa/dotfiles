return {
  "stevearc/conform.nvim",
  event = { "InsertEnter", "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      javascript = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      typescript = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      lua = { "stylua" },
    },
    formatters = {
      oxfmt = {
        prepend_args = { "--stdin-filepath", "$FILENAME" },
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
