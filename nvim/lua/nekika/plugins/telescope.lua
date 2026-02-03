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

        local function map(desc, lhs, rhs, opts)
            opts = vim.tbl_deep_extend("keep", opts or {}, {
                mode = "n",
            })
            vim.keymap.set(opts.mode, lhs, rhs, { desc = desc })
        end

        map("List buffers", "<leader><leader>", builtin.buffers)
        map("Search files", "<leader>sf", builtin.find_files)
        map("Search by grep", "<leader>sg", builtin.live_grep)
        map("Search help tags", "<leader>sh", builtin.help_tags)
        map("Search implementations", "<leader>si", builtin.lsp_implementations)
        map("Search references", "<leader>sr", builtin.lsp_references)
    end,
}
