return {
  "iamcco/markdown-preview.nvim",
  lazy = false,
  ft = { "markdown" },
  cmd = { "MarkdownPreview", "MarkdownPreviewToggle" },
  config = function()
    vim.fn["mkdp#util#install"]()
    vim.keymap.set({ "n", "v" }, "<Leader>mp", "<cmd>MarkdownPreviewToggle<cr>")
  end,
}
