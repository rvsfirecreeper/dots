require("config.lazy")
-- setup must be called before loading
-- disable netrw at the very start of your init.lua

-- optionally enable 24-bit colour

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})
vim.opt.fillchars = {eob = " "}
local pywal16 = require('pywal16')

pywal16.setup()
