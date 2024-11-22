local M = {}

local function quit(window)
  vim.api.nvim_win_close(window, true)
end

local function checkout(lines, window)
  local position = vim.api.nvim_win_get_cursor(window)
  local row = position[1]
  local branch = string.gsub(lines[row], "[* \n]", "")
  vim.system({ 'git', 'checkout', branch }, {}):wait()
  quit(window)
end

function M.branch()
  local object = vim.system({ 'git', 'branch' }, { text = true }):wait()
  if object.code ~= 0 then
    error "Oopsie"
  end

  local lines = {}
  string.gsub(object.stdout or "", "[^\n]+", function(line) table.insert(lines, line) end)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local win = vim.api.nvim_open_win(buf, true, { split = "left", width = 30 })

  vim.keymap.set('n', '<CR>', function() checkout(lines, win) end, { buffer = buf })
  vim.keymap.set('n', 'q', function() quit(win) end, { buffer = buf })
end

return M
