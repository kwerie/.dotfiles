-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <leader>h in normal mode
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>jd', function()
  vim.diagnostic.jump { count = 1 }
end, { desc = 'Jump to next diagnostic' })
vim.keymap.set('n', '<leader>pd', function()
  vim.diagnostic.jump { count = -1 }
end, { desc = 'Jump to previous diagnostic' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- File explorer keymaps
vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>', { desc = '[E]xplore (open netrw)' })
vim.keymap.set('n', '<leader>se', '<cmd>Sex<CR>', { desc = '[E]xplore [H]orizontal split' })
vim.keymap.set('n', '<leader>ve', '<cmd>Vex<CR>', { desc = '[E]xplore [V]ertical split' })
