require("core.lsp.handlers").setup()

local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Global LSP Configuration
vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

-- Lua Language Server
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

-- Go Language Server
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

-- JSON Language Server
vim.lsp.config("jsonls", {
  settings = {
    json = {
      validate = { enable = true },
    },
  },
})

-- TypeScript Language Server (TS7 native LSP)
-- TS7 ships a built-in LSP: tsc --lsp --stdio
-- No typescript-language-server wrapper needed.
vim.lsp.config("ts_ls", {
  cmd = { "node", "./node_modules/typescript/lib/tsc.js", "--lsp", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "tsconfig.json", "package.json", ".git" },
  single_file_support = true,
})

-- Bash Language Server
vim.lsp.config("bashls", {})

-- Emmet Language Server
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

-- QML Language Server (Qt/QML development)
vim.lsp.config("qmlls", {
  cmd = { "qmlls6", "-E" },
  filetypes = { "qml" },
  root_markers = { "qmldir", ".git" },
})

-- -- C++ Language Server (Qt C++ development)
-- vim.lsp.config("clangd", {
--   cmd = { "clangd", "--background-index", "--clang-tidy" },
--   filetypes = { "c", "cpp", "objc", "objcpp" },
--   root_markers = { "compile_commands.json", ".clangd", ".git" },
-- })

-- Enable all configured servers
-- vim.lsp.enable({ "lua_ls", "gopls", "jsonls", "bashls", "emmet_ls", "ts_ls", "zls", "qmlls", "clangd" })

-- LspAttach: buffer-local keymaps (only for keys NOT provided by 0.12 defaults)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = "LSP: " .. desc })
    end

    -- Navigation (0.12 provides: grr=refs, gri=impl, grn=rename, gra=code_action, gO=symbols, K=hover, grt=type_def)
    map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
    map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")

    -- Workspace
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List Workspace Folders")

    -- Format (conform handles save, this is manual)
    map("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, "Format Buffer")

    -- Inlay hints toggle
    map("n", "<leader>ih", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "Toggle Inlay Hints")
  end,
})
