return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local filetypes = {
            "css",
            "docker",
            "elixir",
            "go",
            "html",
            "javascript",
            "json",
            "markdown",
            "templ",
            "typescript",
            "rust",
            "vue",
            "yaml",
            "zig",
        }

        require("nvim-treesitter").install(filetypes)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
