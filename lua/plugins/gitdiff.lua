return {
  "sindrets/diffview.nvim",
  keys = {
      {"<Leader>gp",   "<CMD>DiffviewFileHistory<CR>", desc = "view git diff for branch" },
      {"<Leader>gP",   "<CMD>DiffviewFileHistory %<CR>", desc = "view git diff for branch" },
      {"<Leader>ge",   "<CMD>DiffviewOpen<cr>", desc = "view git diff in file explorer" },
  },
}
