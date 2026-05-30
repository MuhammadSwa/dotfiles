-- nvim-cmp Configuration (Modern Completion Engine)
-- Optimized for frontend development with TypeScript/JavaScript

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  vim.notify("nvim-cmp could not be loaded", vim.log.levels.ERROR)
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

-- Completion Icons (Nerd Font Required)
local kind_icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
  Codeium = "",
  Copilot = "",
}

-- Main CMP Setup
cmp.setup({
  snippet = {
    expand = function(args)
      if luasnip_status_ok then
        luasnip.lsp_expand(args.body)
      elseif vim.snippet then
        vim.snippet.expand(args.body)
      end
    end,
  },

  window = {
    completion = cmp.config.window.bordered({ border = "rounded" }),
    documentation = cmp.config.window.bordered({ border = "rounded" }),
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip_status_ok and luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip_status_ok and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = kind_icons[vim_item.kind] or ""
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        copilot = "[AI]",
        codeium = "[AI]",
        lazydev = "[Lua]",
      })[entry.source.name]
      return vim_item
    end,
  },

  sources = cmp.config.sources({
    { name = "luasnip", group_index = 1, keyword_length = 2 },
    { name = "lazydev", group_index = 0 },
    { name = "copilot", group_index = 1 },
    { name = "nvim_lsp", group_index = 1 },
    { name = "path", group_index = 1 },
    { name = "buffer", group_index = 2, keyword_length = 3 },
  }),

  experimental = { ghost_text = false },
})

-- Cmdline Completion
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

-- Autopairs Integration
local autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if autopairs_ok then
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
