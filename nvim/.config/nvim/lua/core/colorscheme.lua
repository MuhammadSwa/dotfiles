-- ═══════════════════════════════════════════════════════════════════
-- Colorscheme Configuration
-- Using Tokyo Night (night variant)
-- ═══════════════════════════════════════════════════════════════════

-- Apply colorscheme safely
local colorscheme = "tokyonight-night"

local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
  vim.notify("Colorscheme " .. colorscheme .. " not found, using default", vim.log.levels.WARN)
  vim.cmd.colorscheme("default")
  vim.opt.background = "dark"
end
