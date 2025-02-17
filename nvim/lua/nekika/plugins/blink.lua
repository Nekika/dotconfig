return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  version = "*",
  opts = {
    appearance = {
      nerd_font_variant = "mono",
      use_nvim_cmp_as_default = true,
    },
    keymap = {
      preset = "super-tab",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
  opts_extend = { "sources.default" },
}
