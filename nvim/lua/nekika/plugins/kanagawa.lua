return {
  "rebelot/kanagawa.nvim",
  opts = {
    background = {
      dark = "wave",
      light = "lotus"
    }
  },
  init = function()
    vim.cmd.colorscheme "kanagawa"
  end
}
