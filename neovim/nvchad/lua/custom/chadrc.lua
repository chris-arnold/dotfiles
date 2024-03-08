---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

vim.opt.listchars:append { tab = ">-", eol = "¬", nbsp = "▪", space = "␣" }
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
})

-- vim.opt.smarttab = true
-- vim.opt.smartindent = false
-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth = 4

M.ui = {
  theme = "bearded-arc",
  theme_toggle = { "gruvbox", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
