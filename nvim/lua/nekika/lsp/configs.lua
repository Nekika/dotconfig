local coq = require("coq")
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
  { name = "gleam" },
  { name = "gopls" },
  { name = "html" },
  { name = "jsonls" },
  {
    name = "lua_ls",
    options = {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = {
              'vim',
              'require'
            },
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
  },
  { name = "svelte" },
  {
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
      filetypes = { 'typescript', 'javascript', 'vue' },
    }
  },
  { name = "volar" },
  { name = "zls" },
}

local function setup(config)
  config.options = config.options or {}
  lspconfig[config.name].setup(coq.lsp_ensure_capabilities(config.options))
end

for _, config in ipairs(configs) do
  setup(config)
end
