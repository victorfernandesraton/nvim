return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  lazy = false,
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>" },
  },
  opts = {
    -- Your settings go here
  },
}
