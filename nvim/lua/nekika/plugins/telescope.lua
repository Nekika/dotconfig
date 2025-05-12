local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")

local function edit_directory(prompt_bufnr)
    local picker = actions_state.get_current_picker(prompt_bufnr)
    local selection = picker:get_selection()
    local dir, _ = string.match(selection[1], "(.*/)(.*)")
    vim.cmd("edit! " .. dir)
end

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-e>"] = edit_directory,
                    },
                    n = {
                        ["<C-e>"] = edit_directory,
                        ["dd"] = actions.delete_buffer,
                    },
                },
            },
        })

        vim.keymap.set(
            "n",
            "<leader>sf",
            builtin.find_files,
            { desc = "Search files" }
        )
        vim.keymap.set(
            "n",
            "<leader>sg",
            builtin.live_grep,
            { desc = "Search by grep" }
        )
        vim.keymap.set(
            "n",
            "<leader>sh",
            builtin.help_tags,
            { desc = "Search help tags" }
        )
        vim.keymap.set(
            "n",
            "<leader>si",
            builtin.lsp_implementations,
            { desc = "Search implementaions" }
        )
        vim.keymap.set(
            "n",
            "<leader>sr",
            builtin.lsp_references,
            { desc = "Search references" }
        )
        vim.keymap.set(
            "n",
            "<leader><leader>",
            builtin.buffers,
            { desc = "Search buffers" }
        )
    end,
}
