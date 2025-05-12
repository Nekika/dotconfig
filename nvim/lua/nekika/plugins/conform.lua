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
}
