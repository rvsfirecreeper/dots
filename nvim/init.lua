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
local function disable_arrow_keys(mode)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, '<Up>', '<Nop>', opts)
  vim.api.nvim_set_keymap(mode, '<Down>', '<Nop>', opts)
  vim.api.nvim_set_keymap(mode, '<Left>', '<Nop>', opts)
  vim.api.nvim_set_keymap(mode, '<Right>', '<Nop>', opts)
end

-- Disable in all major modes
disable_arrow_keys('n') -- normal
disable_arrow_keys('i') -- insert
disable_arrow_keys('v') -- visual
local pywal16 = require('pywal16')
vim.opt.fillchars = { eob = ' ' }

pywal16.setup()
