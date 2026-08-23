require("core.lsp.handlers").setup()

-- Make Mason-installed binaries resolvable before Mason loads (Mason itself is
-- deferred to VeryLazy). Without this, opening a file as a CLI argument fires
-- FileType before Mason runs, and the first LSP attach attempt fails.
local mason_bin = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")
if vim.uv.fs_stat(mason_bin) then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

-- Filetype detection for GNOME file types
vim.filetype.add({
  extension = {
    blp = "blueprint",
  },
  pattern = {
    [".*%.ui"] = "xml", -- GtkBuilder UI files
  },
})

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

-- Resolve a TS7-native LSP binary (tsgo / tsc --lsp --stdio)
local function get_ts7_cmd()
  -- 1) tsgo on PATH (@typescript/native-preview)
  local tsgo = vim.fn.exepath("tsgo")
  if tsgo ~= "" then
    return { tsgo, "--lsp", "--stdio" }
  end

  -- 2/3) global npm install: native-preview or future stable typescript
  local ok, res = pcall(vim.fn.system, { "npm", "root", "-g" })
  if ok and vim.v.shell_error == 0 then
    local root = vim.trim(res)
    for _, candidate in ipairs({
      vim.fs.joinpath(root, "@typescript", "native-preview", "lib", "tsgo.js"),
      vim.fs.joinpath(root, "typescript", "lib", "tsc.js"),
    }) do
      if vim.uv.fs_stat(candidate) then
        return { "node", candidate, "--lsp", "--stdio" }
      end
    end
  end

  return nil
end

-- TypeScript Language Server (TS7 native LSP)
-- TS7 ships a built-in LSP: tsc --lsp --stdio
-- No typescript-language-server wrapper needed.
-- Falls back to the nvim-lspconfig template (typescript-language-server) if absent.
--
-- Resolution is deferred to the first JS/TS FileType: `npm root -g` is a
-- ~200ms subprocess and would otherwise block startup.
local TS_FT = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserTslsSetup", { clear = true }),
  pattern = TS_FT,
  once = true,
  callback = function()
    local cmd = get_ts7_cmd()
    if cmd then
      vim.lsp.config("ts_ls", {
        cmd = cmd,
        filetypes = TS_FT,
        root_markers = { "tsconfig.json", "package.json", ".git" },
      })
      vim.lsp.enable("ts_ls")
    end
  end,
  desc = "Resolve TS7 native LSP (tsgo/tsc --lsp) on first JS/TS buffer",
})

-- Astro Language Server
-- tsdk is auto-detected from the project's node_modules by astro-ls,
-- so no init_options needed (avoids stale vim.fn.getcwd() at startup).

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

-- Blueprint Language Server (GNOME UI language, .blp files)
vim.lsp.config("blueprint_ls", {
  cmd = { "blueprint-compiler", "lsp" },
  filetypes = { "blueprint" },
  root_markers = { "meson.build", ".git" },
})

-- XML Language Server (GtkBuilder .ui, GSettings schemas, appstream metainfo)
vim.lsp.config("lemminx", {
  filetypes = { "xml", "svg" },
  root_markers = { "meson.build", ".git" },
  settings = {
    xml = {
      format = { splitAttributes = true },
    },
  },
})

-- Enable all configured servers (ts_ls is enabled lazily on first JS/TS buffer)
vim.lsp.enable({ "lua_ls", "gopls", "jsonls", "bashls", "emmet_ls", "zls", "qmlls", "astro", "blueprint_ls", "lemminx" })

-- LspAttach: buffer-local keymaps (only for keys NOT provided by 0.12 defaults)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Built-in LSP document colors (0.12+)
    if vim.lsp.document_color then
      vim.lsp.document_color.enable(true, { bufnr = ev.buf })
    end

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
