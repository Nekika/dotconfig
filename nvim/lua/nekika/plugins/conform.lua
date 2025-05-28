return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            css = { "prettier" },
            go = { "gofmt" },
            html = { "prettier" },
            javascript = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            typescript = { "prettier" },
            vue = { "prettier" },
            yaml = { "prettier" },
            zig = { "zigfmt" },
        },
    },
    config = function(_, opts)
        local conform = require("conform")

        conform.setup(opts)

        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(args)
                conform.format({ bufnr = args.buf })
            end,
        })
    end,
}
