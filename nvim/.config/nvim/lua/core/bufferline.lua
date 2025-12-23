local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup({
  options = {
    mode = "buffers",
    numbers = "none",
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator = {
      icon = "▎",
      style = "icon",
    },
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    truncate_names = true,
    diagnostics = false, -- DISABLED: nvim_lsp diagnostics are heavy
    diagnostics_update_in_insert = false,

    -- DISABLED: custom_areas diagnostic counting is heavy
    -- custom_areas = {
    --   right = function()
    --     local result = {}
    --     local seve = vim.diagnostic.severity
    --     local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
    --     local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
    --     local info = #vim.diagnostic.get(0, { severity = seve.INFO })
    --     local hint = #vim.diagnostic.get(0, { severity = seve.HINT })
    --     if error ~= 0 then
    --       table.insert(result, { text = "  " .. error, fg = "#EC5241" })
    --     end
    --     if warning ~= 0 then
    --       table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
    --     end
    --     if hint ~= 0 then
    --       table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
    --     end
    --     if info ~= 0 then
    --       table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
    --     end
    --     return result
    --   end,
    -- },

    offsets = {
      {
        filetype = "NvimTree",
        text = "NvimTree",
        text_align = "center",
        padding = 1,
      },
    },

    color_icons = true,
    get_element_icon = function(element)
      local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = true })
      return icon, hl
    end,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "thin",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    groups = {
      items = {
        require("bufferline.groups").builtin.pinned:with({ icon = "" }),
      },
    },
  },

  highlights = {},
})
