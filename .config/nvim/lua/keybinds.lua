local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Vim tab navigation
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', opts)
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', opts)
vim.keymap.set('n', '<leader>tt', ':tabprevious<CR>', opts)

vim.keymap.set('n', '<F4>', ':NvimTreeToggle<CR>',opts)
vim.keymap.set('i', '<F4>', ':NvimTreeToggle<CR>',opts)
vim.keymap.set('c', '<F4>', ':NvimTreeToggle<CR>',opts)

vim.keymap.set('n', '<C-/>',':call nerdcommenter#Comment(0, "toggle")<CR>', {})
vim.keymap.set('v', '<C-/>',':call nerdcommenter#Comment(0, "toggle")<CR>', {})
vim.keymap.set('i', '<C-/>','<ESC>:call nerdcommenter#Comment(0, "toggle")<CR>a', {})
