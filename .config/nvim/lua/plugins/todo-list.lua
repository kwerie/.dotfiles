return {
  'https://codeberg.org/kwerie/todo-list.nvim',
  version = 'v1.0.0',
  config = function()
    local todo_list_pluigin = require 'todo-list'

    todo_list_pluigin.setup {}

    vim.api.nvim_set_keymap('n', '<leader>td', ':BrowseTodos<CR>', { noremap = true, silent = true })
  end,
}
