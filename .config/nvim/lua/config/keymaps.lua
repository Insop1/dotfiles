-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>T", function()
  vim.fn.jobstart({ "footclient", "-D", vim.fn.getcwd() }, { detach = true })
end, { desc = "Open terminal" })

vim.keymap.set({ "n", "v" }, "c", '"_c')
vim.keymap.set({ "n", "v" }, "C", '"_C')
vim.keymap.set({'n', 'i', 'v'}, '<C-z>', '<Nop>')
