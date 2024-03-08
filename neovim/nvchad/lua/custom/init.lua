-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",

--- Enable other providers
for _, provider in ipairs { "python3" } do
  vim.g["loaded_" .. provider .. "_provider"] = nil
  vim.cmd("runtime " .. provider)
end

vim.keymap.set("n", "q", "")
