local refactoring = require("refactoring")

refactoring.setup()

vim.keymap.set("n", "<leader>rb", function() refactoring.refactor("Extract Block") end)
vim.keymap.set("x", "<leader>rf", function() refactoring.refactor("Extract Function") end)
vim.keymap.set("n", "<leader>rF", function() refactoring.refactor("Inline Function") end)
vim.keymap.set("x", "<leader>rv", function() refactoring.refactor("Extract Variable") end)
vim.keymap.set({ "n", "x" }, "<leader>rV", function() refactoring.refactor("Inline Variable") end)
