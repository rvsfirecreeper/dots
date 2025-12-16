return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
    },
  },
  require("lspconfig").qmlls.setup({}),
}
