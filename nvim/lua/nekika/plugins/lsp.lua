return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "saghen/blink.cmp",
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local lspconfig = require("lspconfig")

    local configs = {
      { name = "cssls" },
      { name = "dockerls" },
      {
        name = "elixirls",
        options = {
          cmd = { "/usr/local/share/elixir-ls/language_server.sh" }
        }
      },
      { name = "gopls" },
      { name = "html" },
      { name = "jsonls" },
      {
        name = "lua_ls",
        options = {
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
            }
          }
        }
      }, {
      name = "ts_ls",
      options = {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = os.getenv("NODE_GLOBAL_MODULES_DIR") .. "/@vue/language-server",
              languages = { "vue" },
            }
          }
        },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" },
      }
    },
      { name = "volar" },
      { name = "zls" },
    }

    for _, config in ipairs(configs) do
      config.options = config.options or {}
      config.options.capabilities = capabilities
      lspconfig[config.name].setup(config.options)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

        vim.keymap.set("i", "<C-CR>", "<C-x><C-o>", { buffer = 0, desc = "Trigger completion" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Display documentation" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "Go to the definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "Go to declaration" })
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0, desc = "Go to type definition" })
        vim.keymap.set("n", "<F6>", vim.lsp.buf.rename, { buffer = 0, desc = "Rename all references" })
        vim.keymap.set({ "i", "n" }, "<F2>", vim.lsp.buf.code_action, { buffer = 0, desc = "List code actions" })
      end
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        vim.lsp.buf.format({
          bufnr = args.buf,
          async = false,
          timeout_ms = 10000,
        })
      end,
    })
  end,
}
