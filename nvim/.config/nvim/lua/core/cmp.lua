local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  vim.notify("nvim-cmp could not be loaded", vim.log.levels.ERROR)
  return
end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
  vim.notify("LuaSnip could not be loaded for nvim-cmp", vim.log.levels.WARN)
  -- Snippet features will be limited if luasnip is not available
end

-- Safely attempt to load the VSCode snippet loader
local vscode_loader_ok, vscode_loader = pcall(require, "luasnip.loaders.from_vscode")

if not vscode_loader_ok then
  -- Optional: Notify if the loader itself couldn't be required
  -- This might happen if luasnip isn't fully installed or has issues
  vim.notify("LuaSnip VSCode loader module not found.", vim.log.levels.WARN)
else
  -- Check if the loaded module actually has the lazy_load function
  if vscode_loader and vscode_loader.lazy_load then
    -- Now call lazy_load on the actual module table
    vscode_loader.lazy_load()
    -- vim.notify("VSCode snippets lazy-loaded for LuaSnip.", vim.log.levels.INFO) -- Optional success message
  else
    -- This case is less likely but possible if the module structure changed
    vim.notify("LuaSnip VSCode loader found, but lazy_load function is missing.", vim.log.levels.WARN)
  end
end


-- Helper function to check for word before cursor
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
  Copilot = "",
  lazydev = "󰒲",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet


cmp.setup({
  view = {
    entries = { name = "custom", selection_order = "near_cursor" }
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      if luasnip_status_ok then
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      else
        vim.notify("LuaSnip not available for expansion", vim.log.levels.WARN)
        -- Fallback or error handling if needed
      end
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

      -- For `mini.snippets` users:
      -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      -- insert({ body = args.body }) -- Insert at cursor
      -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
      -- require("cmp.config").set_onetime({ sources = {} })
    end,
  },
  window = {
    -- Keep your bordered window setup
    completion = cmp.config.window.bordered({
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Your specific border chars
    }),
    documentation = cmp.config.window.bordered({
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Your specific border chars
    }),
  },

  -- Default confirmation behavior (used by the enhanced <CR> mapping)
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace, -- Default behavior: Replace existing text
    select = false,                         -- Default: require explicit selection
  },

  mapping = cmp.mapping.preset.insert({
    -- ['<C-n>'] = cmp.mapping.select_next_item(),
    -- ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 'c' }),

    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 'c' }),
    -- Navigation
    -- ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), -- Use C-k/C-j for selection nav
    -- ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),

    -- Scrolling Documentation
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    -- Manual Completion Trigger
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Abort/Close
    ['<C-e>'] = cmp.mapping.abort(),
    -- ['<Esc>'] = cmp.mapping.abort(),                    -- Add Escape to abort

    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    -- Navigate between items
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }), -- i = insert mode, s = select mode
    --
    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    expandable_indicator = true,
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind] or "") -- Use '?' icon if kind not in table
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- what shows inside []
      -- Menu text (source indicator)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        codeium = "[Codeium]",
        lazydev = "[LazyDev]", -- Add if using cmp-lazydev
        nvim_lua = "[Lua]",    -- Example if using cmp-nvim-lua
        -- Add other sources you use here
      })[entry.source.name]

      return vim_item
    end,
  },
  -- sources = cmp.config.sources({
  --   { name = "lazydev", group_index = 0 },
  --   { name = "codeium" },
  --   { name = 'nvim_lsp' },
  --   { name = "luasnip", keyword_length = 2 },
  --   { name = "buffer",  keyword_length = 3 },
  --   { name = "path" },
  --   -- { name = 'vsnip' },   -- For vsnip users.
  --   -- { name = 'ultisnips' }, -- For ultisnips users.
  --   -- { name = 'snippy' }, -- For snippy users.
  -- }, {
  --   { name = 'buffer' },
  -- }),
  -- Define Completion Sources (cleaned up and combined)
  sources = cmp.config.sources({
    -- Prioritize your sources here
    { name = "nvim_lsp", group_index = 1 },                     -- Give LSP higher priority maybe
    { name = "codeium",  group_index = 1 },                     -- Give AI tools high priority
    { name = "luasnip",  group_index = 1, keyword_length = 2 }, -- Keep your keyword length
    { name = "buffer",   group_index = 1, keyword_length = 3 }, -- Keep your keyword length
    { name = "path",     group_index = 1 },
    { name = "lazydev",  group_index = 0 },                     -- Keep lazydev separate if needed
    -- Add other sources like nvim_lua if you install them
    -- { name = "nvim_lua", group_index = 1 },
  }),

  experimental = {
    ghost_text = true,
  },
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]] --

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),

  matching = {
    disallow_symbol_nonprefix_matching = false,
  }

})

-- If you want insert `(` after select function or method item
local autopairs_status_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if autopairs_status_ok then
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
else
  vim.notify("nvim-autopairs not found, disabling cmp integration", vim.log.levels.WARN)
end

-- LSP Capabilities Setup (Crucial Part!)
-- Ensure this runs *after* cmp is setup but *before* your LSPs are attached.
-- It's often best placed near your lspconfig setup.
local capabilities = vim.lsp.protocol.make_client_capabilities() -- Get default capabilities
local cmp_caps_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_caps_status_ok then
  -- Enhance defaults with cmp capabilities
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
else
  vim.notify("cmp_nvim_lsp not found, LSP completion might not work optimally", vim.log.levels.WARN)
end
-- IMPORTANT: You need to pass these capabilities to *every* LSP server setup
-- Example for lua_ls (ensure you do this for all servers like pyright, tsserver, etc.)
-- This part usually goes in your main lspconfig file, not directly in cmp.lua
-- Example structure (adapt to your LSP config location):
-- local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
-- if lspconfig_status_ok then
--   lspconfig.lua_ls.setup({
--      capabilities = capabilities, -- Pass the enhanced capabilities here!
--      -- other lua_ls settings...
--   })
--   lspconfig.pyright.setup({
--      capabilities = capabilities, -- Pass the enhanced capabilities here!
--      -- other pyright settings...
--   })
--   -- ... and so on for all your language servers
-- end
