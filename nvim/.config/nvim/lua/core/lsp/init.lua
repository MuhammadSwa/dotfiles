-- Modern Neovim 0.11+ LSP Configuration

require("core.lsp.handlers").setup()

-- Enable inlay hints globally by default (Neovim 0.10+)
-- vim.lsp.inlay_hint.enable(true)

-- Get capabilities from blink.cmp for enhanced completion
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- ═══════════════════════════════════════════════════════════════════
-- Global LSP Configuration (applies to all servers)
-- ═══════════════════════════════════════════════════════════════════
vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

-- ═══════════════════════════════════════════════════════════════════
-- Lua Language Server
-- ═══════════════════════════════════════════════════════════════════
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
      hint = { enable = true },
    },
  },
})

-- ═══════════════════════════════════════════════════════════════════
-- Go Language Server
-- ═══════════════════════════════════════════════════════════════════
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

-- ═══════════════════════════════════════════════════════════════════
-- JSON Language Server (with schemastore support)
-- ═══════════════════════════════════════════════════════════════════
vim.lsp.config("jsonls", {
  settings = {
    json = {
      validate = { enable = true },
    },
  },
})

-- ═══════════════════════════════════════════════════════════════════
-- Bash Language Server
-- ═══════════════════════════════════════════════════════════════════
vim.lsp.config("bashls", {})

-- ═══════════════════════════════════════════════════════════════════
-- HTML Language Server
-- ═══════════════════════════════════════════════════════════════════
-- vim.lsp.config("html", {
--   init_options = {
--     provideFormatter = false, -- Use prettier instead
--   },
-- })

-- ═══════════════════════════════════════════════════════════════════
-- CSS Language Server
-- ═══════════════════════════════════════════════════════════════════
-- vim.lsp.config("cssls", {
--   settings = {
--     css = { validate = true, lint = { unknownAtRules = "ignore" } },
--     scss = { validate = true },
--     less = { validate = true },
--   },
-- })

-- ═══════════════════════════════════════════════════════════════════
-- Tailwind CSS Language Server (Frontend Essential)
-- ═══════════════════════════════════════════════════════════════════
-- vim.lsp.config("tailwindcss", {
--   filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
--   settings = {
--     tailwindCSS = {
--       experimental = {
--         classRegex = {
--           -- SolidJS/React class attribute patterns
--           { "class\\s*=\\s*[\"']([^\"']*)[\"']", 1 },
--           { "classList\\s*=\\s*\\{([^}]*)\\}", 1 },
--           { "className\\s*=\\s*[\"']([^\"']*)[\"']", 1 },
--           -- clsx/classnames/cn patterns
--           { "(?:clsx|classnames|cn|cva|cx)\\(([^)]*)\\)", 1 },
--           -- tw tagged template literal
--           { "tw`([^`]*)`", 1 },
--         },
--       },
--       includeLanguages = {
--         typescriptreact = "html",
--         javascriptreact = "html",
--       },
--     },
--   },
-- })

-- ═══════════════════════════════════════════════════════════════════
-- Emmet Language Server (Fast HTML/JSX Expansion)
-- ═══════════════════════════════════════════════════════════════════
vim.lsp.config("emmet_ls", {
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  },
})

-- ═══════════════════════════════════════════════════════════════════
-- LspAttach Autocommand - Buffer-local Keymaps & Settings
-- ═══════════════════════════════════════════════════════════════════
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Enable built-in LSP completion if supported (Neovim 0.11+)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    -- Auto-format on save if supported (disabled - using conform.nvim instead)
    -- if client:supports_method("textDocument/formatting") then
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     group = vim.api.nvim_create_augroup("LspFormat." .. ev.buf, { clear = true }),
    --     buffer = ev.buf,
    --     callback = function()
    --       vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
    --     end,
    --   })
    -- end

    -- Buffer local mappings with descriptions
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = "LSP: " .. desc })
    end

    -- Navigation
    map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
    map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
    map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
    map("n", "gr", vim.lsp.buf.references, "Go to References")
    map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
    map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")

    -- Workspace
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List Workspace Folders")

    -- Actions
    map("n", "<leader>D", vim.lsp.buf.type_definition, "Type Definition")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, "Format Buffer")

    -- Inlay hints toggle (Neovim 0.10+)
    map("n", "<leader>ih", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "Toggle Inlay Hints")
  end,
})
