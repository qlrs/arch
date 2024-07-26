return {
  {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {"bash", "python", "go", "c", "html", "css", "lua"},
      highlight = { 
          enable = true,
          disable = {"markdown"},
        },
      indent = { enable = true},
    })
  end
  },

  {
    "nvim-treesitter/nvim-treesitter-context"
  },
}
