local status_ok, codium = pcall(require, "codium")
if not status_ok then
  return
end

codium.setup({

  enable_cmp_source = vim.g.ai_cmp,
  virtual_text = {
    enabled = not vim.g.ai_cmp,
    key_bindings = {
      accept = false, -- handled by nvim-cmp / blink.cmp
      next = "<M-]>",
      prev = "<M-[>",
    },
  },
})
