return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '',
      },
      whitespace = {
        remove_blankline_trail = false,
      },
      scope = {
        enabled = false,
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
    },
    config = function()
      require('todo-comments').setup {}
      vim.keymap.set('n', '<leader>lt', '<cmd>TodoTelescope<cr>', { desc = 'List TODO comments' })
    end,
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup()

      -- Simple and easy statusline
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {}
      vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { desc = 'Close buffer' })
      vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { desc = 'Go to buffer' })
    end,
  },
}
