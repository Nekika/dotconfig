vim.g.mapleader = ' '

vim.keymap.set('', '<Space>', '<Nop>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>p', vim.cmd.Ex)

vim.keymap.set('n', '<leader>h', vim.cmd.noh)

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '[b', vim.cmd.bpreviou)
vim.keymap.set('n', ']b', vim.cmd.bnext)

vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
  { desc = 'Go to previous error' })

vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
  { desc = 'Go to next error' })

vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, { desc = 'Go to next diagnostic' })

vim.keymap.set('n', '<leader>gst', vim.cmd.Git, { desc = 'Open fugitive' })
vim.keymap.set('n', '<leader>gb', require('nekika/git').branch, { desc = 'Lists branches' })
vim.keymap.set('n', '<leader>gco', require('nekika/git').checkout_branch, { desc = 'Checkout to new branch' })
vim.keymap.set('n', '<leader>gd', function() vim.cmd('Git diff') end, { desc = 'List diffs' })
vim.keymap.set('n', '<leader>glg', function() vim.cmd('Git log') end, { desc = 'List commits' })
vim.keymap.set('n', '<leader>ggl', function() vim.cmd('Git pull') end, { desc = 'Pull latest commits' })
vim.keymap.set('n', '<leader>gp', function() vim.cmd('Git push') end, { desc = 'Push latest commits' })

vim.keymap.set('n', '<leader>tc', vim.cmd.tabclose, { desc = 'Close current tab' })
vim.keymap.set('n', '<leader>tn', vim.cmd.tabnew, { desc = 'Create new tab' })
vim.keymap.set('n', '[t', vim.cmd.tabprevious, { desc = 'Go to previous tab' })
vim.keymap.set('n', ']t', vim.cmd.tabnext, { desc = 'Go to next tab' })

vim.keymap.set('n', '<leader>rb', function() require('refactoring').refactor('Extract Block') end)
vim.keymap.set('x', '<leader>rf', function() require('refactoring').refactor('Extract Function') end)
vim.keymap.set('n', '<leader>rF', function() require('refactoring').refactor('Inline Function') end)
vim.keymap.set('x', '<leader>rv', function() require('refactoring').refactor('Extract Variable') end)
vim.keymap.set({ 'n', 'x' }, '<leader>rV', function() require('refactoring').refactor('Inline Variable') end)

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Search by grep' })
vim.keymap.set('n', '<leader>si', require('telescope.builtin').lsp_implementations, { desc = 'Search implementaions' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').lsp_references, { desc = 'Search references' })
vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers, { desc = 'Search buffers' })

vim.keymap.set('n', '[w', '<C-w>W')
vim.keymap.set('n', ']w', '<C-w>w')

vim.keymap.set({ 'n', 'v' }, '<C-y>', '"ay')
vim.keymap.set({ 'n', 'v' }, '<C-p>', '"ap')

vim.keymap.set('t', '<ESC><ESC>', '<C-\\><C-n>')
