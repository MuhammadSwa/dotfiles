local M = {}

M.setup = function()
  vim.diagnostic.config({
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '',
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      },
      -- linehl = {
      --   [vim.diagnostic.severity.ERROR] = "DiagnosticVirtualTextError",
      -- },
    },
    update_in_insert = false,
    underline = false,
    severity_sort = true,

    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "if_many",
      header = "",
      prefix = "",
    },
  })
end


local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, blink_cmp = pcall(require, "blink.cmp")
if not status_ok then
  return
end

M.capabilities = blink_cmp.get_lsp_capabilities(capabilities)


return M
