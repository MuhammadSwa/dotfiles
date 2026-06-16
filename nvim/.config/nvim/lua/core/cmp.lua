-- blink.cmp Configuration (High-Performance Completion Engine)
-- Optimized for frontend development with TypeScript/JavaScript/SolidJS

local blink_status_ok, blink = pcall(require, "blink.cmp")
if not blink_status_ok then
  vim.notify("blink.cmp could not be loaded", vim.log.levels.ERROR)
  return
end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
  vim.notify("LuaSnip could not be loaded", vim.log.levels.WARN)
end

-- Load VSCode-style snippets (from friendly-snippets)
local vscode_loader_ok, vscode_loader = pcall(require, "luasnip.loaders.from_vscode")
if vscode_loader_ok and vscode_loader.lazy_load then
  vscode_loader.lazy_load()
end

-- Load custom SolidJS snippets
pcall(require, "core.snippets.solidjs")

-- Main blink.cmp Setup
blink.setup({
  -- Keymaps (preset "none" for custom bindings matching your legacy setup)
  keymap = {
    preset = "none",
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-y>"] = { "accept", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },

  -- Snippet engine preset
  snippets = {
    preset = "luasnip",
  },

  -- Completion window settings
  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    list = {
      selection = {
        preselect = true, -- Automatically select the first item, allowing C-y to insert it immediately
        auto_insert = false,
      },
    },
    menu = {
      border = "rounded",
    },
    documentation = {
      auto_show = true,
      window = {
        border = "rounded",
      },
    },
  },

  -- Define completion sources
  sources = {
    default = { "lazydev", "copilot", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
      copilot = {
        name = "copilot",
        module = "blink-cmp-copilot",
        score_offset = 100,
        async = true,
      },
    },
  },

  -- Aesthetics: Icons configuration matching standard Nerd Fonts
  appearance = {
    nerd_font_variant = "mono",
    kind_icons = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "󰆧",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "󰠱",
      Module = "󰏗",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "󰠱",
      Keyword = "󰌋",
      Snippet = "󰏿",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "󰠱",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "󰉁",
      Operator = "󰆕",
      TypeParameter = "󰊄",
    },
  },

  -- Command-line Autocompletion Setup
  cmdline = {
    enabled = true,
    keymap = {
      preset = "cmdline",
    },
    sources = function()
      local type = vim.fn.getcmdtype()
      if type == "/" or type == "?" then return { "buffer" } end
      if type == ":" or type == "@" then return { "cmdline", "path" } end
      return {}
    end,
  },
})
