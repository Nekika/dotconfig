local M = {}

local function close_current_window()
  vim.api.nvim_win_close(0, true)
end

local function get_branch_under_cursor(branches)
  local position = vim.api.nvim_win_get_cursor(0)
  local row = position[1]
  return string.gsub(branches[row], '[* \n]', ''), row
end

local function checkout_branch_under_cursor(branches)
  local branch = get_branch_under_cursor(branches)

  local object = vim.system({ 'git', 'checkout', branch }, {}):wait()
  if object.code ~= 0 then
    error(object.stderr or object.stdout or '')
  end

  close_current_window()
end

local function delete_branch_under_cursor(branches)
  local branch, index = get_branch_under_cursor(branches)

  local confirm = vim.fn.input('Do you really want to delete the branch ' .. branch .. ' ? (Y/n): ')
  if confirm == 'Y' then
    local object = vim.system({ 'git', 'branch', '-D', branch }):wait()
    if object.code ~= 0 then
      error(object.stderr or object.stdout or '')
    end

    table.remove(branches, index)

    vim.api.nvim_buf_set_lines(0, 0, -1, false, branches)
  end
end

local function list_branches()
  local object = vim.system({ 'git', 'branch' }, { text = true }):wait()
  if object.code ~= 0 then
    error(object.stderr or object.stdout or '')
  end

  local branches = {}
  string.gsub(object.stdout or '', '[^\n]+', function(line) table.insert(branches, line) end)

  return branches
end

function M.branch()
  local branches = list_branches()
  local buffer = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(buffer, 0, -1, false, branches)

  vim.api.nvim_open_win(buffer, true, { split = 'left', width = 60 })

  vim.keymap.set(
    'n',
    '<CR>',
    function() checkout_branch_under_cursor(branches) end,
    { buffer = buffer, desc = 'Checkout to the branch under the cursor' }
  )

  vim.keymap.set(
    'n',
    'D',
    function() delete_branch_under_cursor(branches) end,
    { buffer = buffer, desc = 'Delete the branch under the cursor' }
  )
end

function M.checkout_branch()
  local name = vim.fn.input('New branch name: ')
  if name == '' then
    error 'New branch name must not be empty'
  end

  local object = vim.system({ 'git', 'checkout', '-b', name }, { text = true }):wait()
  if object.code ~= 0 then
    error(object.stderr or object.stdout or '')
  end
end

return M
