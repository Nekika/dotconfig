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

local default_list_options = {
    all = false,
}

function M.list(opts)
    opts = vim.tbl_deep_extend("force", default_list_options, opts or {})

    local cmd = { "git", "branch" }
    if opts.all == true then
        table.insert(cmd, "-a")
    end

    local output = command.run(cmd)

    local branches = {}
    local lines = vim.split(output, "\n", { trimempty = true })
    for _, line in pairs(lines) do
        local branch = {
            active = vim.startswith(line, "* "),
            name = vim.trim(string.gsub(line, "* ", "")),
        }
        table.insert(branches, branch)
    end

    return branches
end

function M.rename(from, to)
    if from == "" or to == "" then
        error("branch name must not ne empty")
    end

    local cmd = { "git", "branch", "-m", from, to }

    return command.run(cmd)
end

return M
