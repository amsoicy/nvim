return {
  "nvim-pack/nvim-spectre",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("spectre").setup()
    vim.keymap.set("n", "<leader>lt", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
  end,
}
