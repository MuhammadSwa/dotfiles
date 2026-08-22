return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-j>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-x>",
        },
      },
      panel = { enabled = false },
    })
  end,
}
