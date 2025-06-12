local M = {}

local default_run_options = {
    lines = false,
}

function M.run(cmd, opts)
    opts = vim.tbl_deep_extend("force", default_run_options, opts or {})

    local result = vim.system(cmd):wait()

    if result.code ~= 0 then
        local message = result.stderr
            or result.stdout
            or string.format("unexpected status code: %d", result.code)
        error(message)
    end

    local output = result.stdout or ""

    if opts.lines == false then
        return output
    end

    return vim.split(output, "\n", { trimempty = true })
end

return M
