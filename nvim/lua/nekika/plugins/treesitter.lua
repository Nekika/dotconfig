return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
        sync_install = true,
        auto_install = true,
        highlight = {
            enable = true,
        },
    },
}
