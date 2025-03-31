local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup({
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    indicator = {
      icon = "▎", -- this should be omitted if indicator style is not 'icon'
      style = "icon", -- | 'underline' | 'none',
    },
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    -- name_formatter = function(buf) -- buf contains:
    -- name                | str        | the basename of the active file
    -- path                | str        | the full path of the active file
    -- bufnr (buffer only) | int        | the number of the active buffer
    -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
    -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
    -- end,
    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    tab_size = 21,
    truncate_names = true,  -- whether or not tab names should be truncated
    diagnostics = "nvim_lsp", -- | false | "coc",
    diagnostics_update_in_insert = false,

    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    --- count is an integer representing total count of errors
    --- level is a string "error" | "warning"
    --- this should return a string
    --- Don't get too fancy as this function will be executed a lot
    -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
    -- 	-- return "(" .. count .. ")"
    -- 	local icon = level:match("error") and " " or "" --"" or ""
    -- 	return "" .. icon  .. count
    -- end,

    -- Please note that this function will be called a lot and should be as inexpensive as possible so it does
    -- not block rendering the tabline.
    custom_areas = {
      right = function()
        local result = {}
        local seve = vim.diagnostic.severity
        local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
        local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
        local info = #vim.diagnostic.get(0, { severity = seve.INFO })
        local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

        if error ~= 0 then
          table.insert(result, { text = "  " .. error, fg = "#EC5241" })
        end

        if warning ~= 0 then
          table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
        end

        if hint ~= 0 then
          table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
        end

        if info ~= 0 then
          table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
        end
        return result
      end,
    },

    -- NOTE this will be called a lot so don't do any heavy processing here
    -- custom_filter = function(buf_number, buf_numbers)
    -- 	-- filter out filetypes you don't want to see
    -- 	if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
    -- 		return true
    -- 	end
    -- 	-- filter out by buffer name
    -- 	if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
    -- 		return true
    -- 	end
    -- 	-- filter out based on arbitrary rules
    -- 	-- e.g. filter out vim wiki buffer from tabline in your work repo
    -- 	if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
    -- 		return true
    -- 	end
    -- 	-- filter out by it's index number in list (don't show first buffer)
    -- 	if buf_numbers[1] ~= buf_number then
    -- 		return true
    -- 	end
    -- end,

    offsets = {
      {
        filetype = "NvimTree",
        text = "NvimTree",
        text_align = "center", --| "left" | "right"
        padding = 1,
      },
    },

    color_icons = true, -- | false -- whether or not to add the filetype icon highlights
    get_element_icon = function(element)
      -- element consists of {filetype: string, path: string, extension: string, directory: string}
      -- This can be used to change how bufferline fetches the icon
      -- for an element e.g. a buffer or a tab.
      -- e.g.
      local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = true })
      return icon, hl
      -- or
      -- local custom_map = {my_thing_ft: {icon = "my_thing_icon", hl}}
      -- return custom_map[element.filetype]
    end,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thin", --| "slant" "slope" | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    -- sort_by = "insert_after_current",
    -- | "insert_at_end"
    -- | "id"
    -- | "extension"
    -- | "relative_directory"
    -- | "directory"
    -- | "tabs"
    -- | function(buffer_a, buffer_b)
    -- 	-- add custom logic
    -- 	return buffer_a.modified > buffer_b.modified
    -- end,
    groups = {
      items = {
        require("bufferline.groups").builtin.pinned:with({ icon = "" }),
        -- ... -- other items
      },
    },
  },

  highlights = {},
})
