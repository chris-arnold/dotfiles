---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- ["<leader>l"] = { ":set list!<CR>"}
    ["<C-j>"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "Diagnostic goto next",
    },
    ["<C-k>"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "Diagnostic goto prev",
    },
  },
}
-- set listchars=tab:>-,eol:¬,nbsp:▪,trail:▪

-- more keybinds!

-- M.disabled = {
--   n = {
--       ["<C-a>"] = ""
--   },
-- }

return M
