local servers = {
    cssls = {},
    dockerls = {},
    elixirls = {
        cmd = { "/usr/local/share/elixir-ls/language_server.sh" },
    },
    gopls = {},
    html = {},
    jsonls = {},
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "require", "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    ts_ls = {
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = os.getenv("NODE_GLOBAL_MODULES_DIR") .. "/@vue/typescript-plugin",
                    languages = { "javascript", "typescript", "vue" },
                },
            },
        },
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
        },
    },
    vue_ls = {},
    zls = {},
}

return {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
        local blink = require("blink.cmp")

        for server, config in pairs(servers) do
            config.capabilities = blink.get_lsp_capabilities(config.capabilities)
            vim.lsp.config(server, config)
            vim.lsp.enable(server)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function()
                local function map(lhs, rhs, description, modes)
                    modes = modes or { "n" }
                    vim.keymap.set(modes, lhs, rhs, { buffer = 0, desc = description })
                end

                map("gd", vim.lsp.buf.definition, "Go to definition")
                map("gD", vim.lsp.buf.type_definition, "Go to declaration")
                map("gt", vim.lsp.buf.type_definition, "Go to type definition")
                map("<F2>", vim.lsp.buf.code_action, "List code actions", { "i", "n" })
                map("<F6>", vim.lsp.buf.rename, "Rename all references")
            end,
        })
    end,
}
