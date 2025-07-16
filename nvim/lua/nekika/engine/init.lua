local M = {}

local default_start_options = {
    buffer = {
        keymaps = {},
        listeners = {},
    },
    window = {
        split = "left",
        width = 60,
    },
}

function M.start(init, view, opts)
    if init == nil or type(init) ~= "function" then
        error("init is mandatory and must be a function")
    end

    if view == nil or type(view) ~= "function" then
        error("view is mandatory and must be a function")
    end

    if opts ~= nil and type(opts) ~= "table" then
        error("options must a table")
    end

    opts = vim.tbl_deep_extend("force", default_start_options, opts or {})

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

    local win = vim.api.nvim_open_win(buf, true, opts.window)

    local function render(model)
        local lines = view(model)
        vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
    end

    local model = init()
    render(model)

    for _, listener in ipairs(opts.buffer.listeners) do
        local function callback()
            model = listener.callback(model)
            render(model)
        end

        vim.api.nvim_create_autocmd(listener.event, { buffer = buf, callback = callback })
    end

    for _, m in ipairs(opts.buffer.keymaps) do
        local function callback()
            local cursor = vim.api.nvim_win_get_cursor(win)
            model = m.callback(model, { cursor = cursor })
            render(model)
        end

        vim.keymap.set(m.mode, m.keys, callback, { buffer = buf, desc = m.desc or "" })
    end
end

return M
