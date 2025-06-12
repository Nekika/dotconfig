local explorer = require("git.explorer")

local M = {}

function M.setup(opts)
    vim.keymap.set({ "n" }, "<leader>gb", explorer.open, { desc = "Open git branches explorer" })
end

return M
