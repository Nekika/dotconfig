return
{
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({})

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search files" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by grep" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help tags" })
    vim.keymap.set("n", "<leader>si", builtin.lsp_implementations, { desc = "Search implementaions" })
    vim.keymap.set("n", "<leader>sr", builtin.lsp_references, { desc = "Search references" })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Search buffers" })
  end,
}
