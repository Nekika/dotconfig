local client = require("git.client")

local M = {}

function M.open()
    local branches = client.branch.list({ all = true })

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, branches)

    local win = vim.api.nvim_open_win(buf, true, { split = "left", width = 60 })

    vim.keymap.set("n", "<CR>", function()
        local index = vim.api.nvim_win_get_cursor(win)[1]
        client.branch.checkout(branches[index])
    end, { buffer = buf, desc = "Checkout to the branch under the cursor" })
end

return M
