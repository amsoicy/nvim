return {
  "omni-spectre",
  dir = "C:\\Users\\Me\\Documents\\dev\\omni-replace",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>S", "<cmd>OmniReplaceToggle<CR>", desc = "Toggle Omni-Spectre" },
    { "<leader>sw", "<cmd>lua require('omni_replace').open_visual({ select_word = true })<CR>", desc = "Search current word" },
    { "<leader>sp", "<cmd>lua require('omni_replace').open_file_search({ select_word = true })<CR>", desc = "Search in current file" },
    { "<leader>h", "<cmd>lua require('omni_replace').show_history()<CR>", desc = "Show replace history" },
    { "<leader>u", "<cmd>lua require('omni_replace.history').undo_last()<CR>", desc = "Undo last replace" },
  },
  config = function()
    require("omni_replace").setup {
      live_update = true,
      open_cmd = "vnew",
      lnum_for_results = true,
      default = {
        find = {
          cmd = "rg",
          options = { "ignore-case" },
        },
        replace = {
          cmd = "vim",
        },
      },
    }
  end,
}
