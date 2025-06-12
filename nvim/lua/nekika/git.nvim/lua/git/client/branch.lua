local command = require("git.client.command")

local M = {}

function M.create(name)
    local cmd = { "git", "branch", name }
    return command.run(cmd)
end

function M.checkout(name, opts)
    opts = opts or {}

    local cmd = { "git", "checkout", name }
    if opts.create == true then
        table.insert(cmd, 3, "-b")
    end

    return command.run(cmd)
end

function M.delete(names, opts)
    if type(names) == "string" then
        names = { names }
    end

    opts = opts or {}

    local flag = "-d"
    if opts.force == true then
        flag = "-D"
    end

    local cmd = { "git", "branch", flag }

    for _, name in ipairs(names) do
        table.insert(cmd, name)
    end

    return command.run(cmd)
end

function M.list(opts)
    opts = opts or {}

    local cmd = { "git", "branch" }
    if opts.all == true then
        table.insert(cmd, "-a")
    end

    local lines = command.run(cmd, { lines = true })
    for i, line in pairs(lines) do
        lines[i] = vim.trim(line)
    end

    return lines
end

function M.rename(from, to)
    if from == "" or to == "" then
        error("branch name must not ne empty")
    end

    local cmd = { "git", "branch", "-m", from, to }

    return command.run(cmd)
end

return M
