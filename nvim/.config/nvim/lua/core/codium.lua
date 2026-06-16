-- ═══════════════════════════════════════════════════════════════════
-- Codeium Configuration (AI Code Completion)
-- Note: codeium.vim is a Vimscript plugin, configured via vim.g variables
-- The keymaps are set in plugins/init.lua for lazy loading
-- ═══════════════════════════════════════════════════════════════════

-- Codeium is configured directly in the plugin spec (plugins/init.lua)
-- This file is kept for any additional customization

-- To disable Codeium for specific filetypes, uncomment and modify:
-- vim.g.codeium_filetypes = {
--   fzf = false,
--   markdown = false,
-- }

-- To disable Codeium globally and enable per-buffer:
-- vim.g.codeium_enabled = false
-- Then use :Codeium Enable in buffers where you want it
