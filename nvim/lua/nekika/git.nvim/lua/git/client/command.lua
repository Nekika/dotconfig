local M = {}

function M.run(cmd)
    local result = vim.system(cmd, { text = true }):wait()

    if result.code ~= 0 then
        local message = result.stderr
            or result.stdout
            or string.format("unexpected status code: %d", result.code)
        error(message)
    end

    return result.stdout or ""
end

return M
