local client = require("git.client")
local engine = require("nekika.engine")

local M = {}

function M.open()
    local function init()
        return {
            branches = client.branch.list({ all = true }),
        }
    end

    local function view(model)
        local lines = {}

        for _, branch in ipairs(model.branches) do
            local prefix = "  "
            if branch.active then
                prefix = "->"
            end
            table.insert(lines, string.format("%s %s", prefix, branch.name))
        end

        return lines
    end

    local opts = {
        buffer = {
            keymaps = {
                {
                    mode = { "n" },
                    keys = "<CR>",
                    desc = "Checkout to the branch under cursor",
                    callback = function(model, context)
                        local index = context.cursor[1]

                        client.branch.checkout(model.branches[index].name)

                        for i, branch in ipairs(model.branches) do
                            model.branches[i] = { active = i == index, name = branch.name }
                        end

                        return model
                    end,
                },
                {
                    mode = { "n" },
                    keys = "o",
                    desc = "Create a new branch",
                    callback = function(model, _)
                        local name = vim.fn.input("Branch name : ")

                        client.branch.create(name)

                        table.insert(model.branches, { active = false, name = name })

                        return model
                    end,
                },
                {
                    mode = { "n" },
                    keys = "dd",
                    desc = "Delete the branch under cursor",
                    callback = function(model, context)
                        local index = context.cursor[1]

                        client.branch.delete(model.branches[index].name)

                        table.remove(model.branches, index)

                        return model
                    end,
                },
                {
                    mode = { "n" },
                    keys = "DD",
                    desc = "Delete the branch under cursor (force)",
                    callback = function(model, context)
                        local index = context.cursor[1]

                        client.branch.delete(model.branches[index].name, { force = true })

                        table.remove(model.branches, index)

                        return model
                    end,
                },
                {
                    mode = { "n" },
                    keys = "r",
                    desc = "Rename the branch under cursor",
                    callback = function(model, context)
                        local index = context.cursor[1]

                        local old = model.branches[index].name
                        local new = vim.fn.input("New name : ", old)

                        client.branch.rename(old, new)

                        model.branches[index].name = new

                        return model
                    end,
                },
            },
        },
    }

    engine.start(init, view, opts)
end

return M
