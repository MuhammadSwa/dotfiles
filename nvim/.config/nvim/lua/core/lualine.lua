local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  print("Problem with lualine")
  return
end

lualine.setup(
  {
    options = {
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_c = {
        {
          'filename',
          path = 1,             -- 0 = just filename, 1 = relative path, 2 = absolute path
          file_status = true,
          shorting_target = 40, -- Shortens path if file name exceeds this length
        }
      },
      -- other sections...
    }
  }
)
