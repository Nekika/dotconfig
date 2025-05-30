vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>p", vim.cmd.Oil)

vim.keymap.set("n", "<leader>h", vim.cmd.noh)

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "[b", vim.cmd.bpreviou)
vim.keymap.set("n", "]b", vim.cmd.bnext)

vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
  { desc = "Go to previous error" })

vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
  { desc = "Go to next error" })

vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Go to next diagnostic" })

vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "Open fugitive" })

vim.keymap.set("n", "<leader>ll", vim.cmd.Lazy, { desc = "Open Lazy" })

vim.keymap.set("n", "<leader>tc", vim.cmd.tabclose, { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew, { desc = "Create new tab" })
vim.keymap.set("n", "[t", vim.cmd.tabprevious, { desc = "Go to previous tab" })
vim.keymap.set("n", "]t", vim.cmd.tabnext, { desc = "Go to next tab" })

vim.keymap.set("n", "[w", "<C-w>W")
vim.keymap.set("n", "]w", "<C-w>w")

vim.keymap.set({ "n", "v" }, "<C-y>", "\"ay")
vim.keymap.set({ "n", "v" }, "<C-p>", "\"ap")

vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>")
