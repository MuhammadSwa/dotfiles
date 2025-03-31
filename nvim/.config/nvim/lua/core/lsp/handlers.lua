local function configure_float()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover(
    {
      border = "rounded",
      max_width = 80,
      max_height = 20,
      focusable = false,
    }
  )
end

-- -- Configure LSP handler overrides (internal helper)
-- local function configure_lsp_handlers()
--   -- use the new api
--   -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--   --   border = "rounded",
--   --   width = 60, -- Optional: Adjust width as needed
--   -- })
--   -- vim.lsp.handlers["textDocument/hover"] = function (err, result, context, config)
--   --
--   --
--   -- end
--   --
--   -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--   --   border = "rounded",
--   --   width = 60, -- Optional: Adjust width as needed
--   -- })
--


-- -- Attach illuminate plugin if available (internal helper)
local function lsp_attach_illuminate(client_id)
  -- Use client_id which is now standard instead of the full client object sometimes
  -- though `client` object passed to on_attach still works fine.
  pcall(function()
    require("illuminate").on_attach(vim.lsp.get_client_by_id(client_id))
  end)
end
--
-- -- Define buffer-local LSP keymaps (internal helper)
-- local function lsp_keymaps(bufnr)
--   local opts = { noremap = true, silent = true, buffer = bufnr }
--   local map = vim.keymap.set -- Use vim.keymap.set for consistency
--
--   map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--   map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--   map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--   map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--   map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- Consider if C-k conflicts elsewhere
--   map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--   map("n", "[d", function() vim.diagnostic.get_prev({ border = "rounded" }) end, opts)
--   map("n", "]d", function() vim.diagnostic.get_next({ border = "rounded" }) end, opts)
--
--   map("n", "gl", function() vim.diagnostic.open_float({ border = "rounded" }) end, opts)
--   -- map("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
--   map("n", "<leader>q", function() vim.diagnostic.setloclist({ open = true }) end, opts)
--
--   -- Consider buffer-local command or keymap instead of global command for formatting
--   map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
--   -- Or keep the global command if preferred, defined outside on_attach if global:
--   -- vim.api.nvim_create_user_command("Format", "lua vim.lsp.buf.format({ async = true })", { desc = "Format code using LSP" })
-- end
--
-- -- Server specific capability overrides (internal data)
-- local server_capabilities_overrides = {
--   tsserver = {
--     documentFormattingProvider = false, -- Use the correct capability name
--     documentRangeFormattingProvider = false,
--   },
--   -- Add other server overrides here if needed
--   -- example_server = { some_capability = false },
-- }
--
-- -- Public: on_attach function to be used by LSP server setups
-- M.on_attach = function(client, bufnr)
--   -- Apply server-specific capability overrides *before* setup functions if needed
--   -- Note: Modifying resolved_capabilities here is generally discouraged.
--   -- It's better to modify the capabilities table *before* starting the client.
--   -- However, if dynamically disabling after attach is the only way:
--   local server_name = client.name
--   if server_capabilities_overrides[server_name] then
--     local overrides = server_capabilities_overrides[server_name]
--     for cap, enable in pairs(overrides) do
--       -- Check if the capability exists before trying to modify it
--       if client.server_capabilities[cap] ~= nil then
--         client.server_capabilities[cap] = enable -- Directly modify server reported capabilities (use with caution)
--         -- Or, for client-side resolved capabilities (less common use case here):
--         -- if client.resolved_capabilities[cap] ~= nil then
--         --   client.resolved_capabilities[cap] = enable
--         -- end
--       end
--     end
--   end
--
--   -- Setup buffer-local keymaps
--   lsp_keymaps(bufnr)
--
--   -- Attempt to attach illuminate
--   -- Pass client.id instead of the full client object if illuminate supports it
--   lsp_attach_illuminate(client.id)
--
--   -- Example: Enable inlay hints for servers that support it (like rust_analyzer)
--   -- if client.supports_method("textDocument/inlayHint") then
--   --   vim.lsp.inlay_hint.enable(bufnr, true)
--   --   vim.keymap.set("n", "<leader>lh", function() vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr)) end, { buffer = bufnr, desc = "Toggle Inlay Hints" })
--   -- end
--
--   -- You could add more buffer-specific setup here, e.g., omnifunc
--   -- vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
-- end
--
-- -- Public: setup function to initialize global settings
-- M.setup = function()
--   -- define_signs()
--   configure_diagnostics()
--   configure_lsp_handlers()
--   -- Define the global Format command here if you prefer it global
--   -- Avoid defining it inside on_attach which runs per buffer/server attach
--   pcall(vim.api.nvim_create_user_command, "Format", "lua vim.lsp.buf.format({ async = true })",
--     { desc = "Format code using LSP" })
-- end
--
-- -- Public: LSP capabilities enhanced with cmp-nvim-lsp
-- -- Compute capabilities once and store them in the module
-- local base_capabilities = vim.lsp.protocol.make_client_capabilities()
-- local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if cmp_nvim_lsp_status_ok then
--   M.capabilities = cmp_nvim_lsp.default_capabilities(base_capabilities)
-- else
--   -- Fallback to base capabilities if cmp_nvim_lsp is not available
--   M.capabilities = base_capabilities
--   vim.notify("cmp-nvim-lsp not found, using default LSP capabilities.", vim.log.levels.WARN)
-- end
--
-- -- IMPORTANT: Return the module table at the end of the file
-- return M
-- Basic diagnostics configuration

local M = {}

local function configure_diagnostics()
  vim.diagnostic.config({
    -- Show virtual text alongside diagnostics
    virtual_text = false,
    -- virtual_text = {
    --   spacing = 4, -- Space between the diagnostic message and code
    --   prefix = '●', -- Prefix each diagnostic with this symbol
    --   source = "if_many", -- Show source only when multiple sources exist
    --   severity = {
    --     min = vim.diagnostic.severity.HINT, -- Show all severities
    --   },
    -- },
    -- Show diagnostic signs in the sign column
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
      linehl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticVirtualTextError",
      },
    },

    -- Enable floating window for more detailed diagnostic info
    float = {
      -- Basic appearance
      border = "rounded", -- Border style: 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
      source = "if_many", -- Show source of diagnostic: 'always', false, 'if_many'
      prefix = function(diagnostic, i, total)
        local icon = "•"
        if diagnostic.severity == vim.diagnostic.severity.ERROR then
          icon = "✗"
        elseif diagnostic.severity == vim.diagnostic.severity.WARN then
          icon = "⚠"
        elseif diagnostic.severity == vim.diagnostic.severity.INFO then
          icon = "ℹ"
        end
        return string.format("%s %d/%d: ", icon, i, total),
            "DiagnosticFloating" .. vim.diagnostic.severity[diagnostic.severity]
      end,
      suffix = function(diagnostic)
        return diagnostic.code and string.format(" [%s]", diagnostic.code) or ""
      end,
      format = function(diagnostic)
        -- Just return the message without additional formatting
        return diagnostic.message
      end,

      -- Content formatting
      format = function(diagnostic)
        -- Custom formatting function
        local message = diagnostic.message
        local source = diagnostic.source
        local code = diagnostic.code

        -- Format based on severity
        if diagnostic.severity == vim.diagnostic.severity.ERROR then
          return string.format("Error[%s]: %s", source, message)
        end

        -- Return formatted message
        return message
      end,

      -- Scope of included diagnostics
      scope = "cursor", -- 'line', 'buffer', or 'cursor'

      -- Focus behavior
      focus_id = "diagnostic_float",

      -- Header text
      header = "Diagnostics:",

      -- Control which diagnostics are shown
      severity = { min = vim.diagnostic.severity.HINT },
    },

    -- Enable underline for diagnostics
    underline = true,

    -- Severity-based sort (higher severity shown first)
    severity_sort = true,

    -- Don't update diagnostics in insert mode
    update_in_insert = false,
  })
end

local function custom_namespace()
  -- Custom namespace for our aggregated signs
  local ns = vim.api.nvim_create_namespace("highest_severity_signs")

  -- Store reference to original signs handler
  local orig_signs_handler = vim.diagnostic.handlers.signs

  -- Override built-in signs handler
  vim.diagnostic.handlers.signs = {
    show = function(_, bufnr, _, opts)
      -- Get all diagnostics from the buffer
      local diagnostics = vim.diagnostic.get(bufnr)

      -- Find worst diagnostic per line
      local max_severity_per_line = {}
      for _, d in pairs(diagnostics) do
        local m = max_severity_per_line[d.lnum]
        if not m or d.severity < m.severity then
          max_severity_per_line[d.lnum] = d
        end
      end

      -- Pass filtered diagnostics to original handler
      local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
      orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
    end,

    hide = function(_, bufnr)
      orig_signs_handler.hide(ns, bufnr)
    end,
  }
end


local function toggle_virtual_lines()
  vim.keymap.set('n', '<Leader>dl', function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config })
  end, { desc = 'Toggle diagnostic virtual lines' })
end


M.setup = function()
  configure_diagnostics()
  custom_namespace()
  toggle_virtual_lines()
  configure_float()
  lsp_attach_illuminate()
end

return M
