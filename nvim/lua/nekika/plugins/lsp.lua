return {
    "neovim/nvim-lspconfig",
    config = function()
        local configs = {
            { "cssls" },
            { "dockerls" },
            {
                "elixirls",
                {
                    cmd = { "/usr/local/share/elixir-ls/language_server.sh" },
                },
            },
            { "gopls" },
            { "html" },
            { "jsonls" },
            {
                "lua_ls",
                {
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
            },
            {
                "ts_ls",
                {
                    init_options = {
                        plugins = {
                            {
                                "@vue/typescript-plugin",
                                location = os.getenv("NODE_GLOBAL_MODULES_DIR")
                                    .. "/@vue/language-server",
                                languages = { "vue" },
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
            },
            { "vue_ls" },
            { "zls" },
        }

        for _, config in ipairs(configs) do
            vim.lsp.config(config[1], config[2] or {})
            vim.lsp.enable(config[1])
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
