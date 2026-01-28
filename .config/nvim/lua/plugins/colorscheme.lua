function SetColorScheme()
  vim.cmd 'colorscheme rose-pine'
end

return {
  {
    'ellisonleao/gruvbox.nvim',
    name = 'gruvbox',
    priority = 1000,
    config = function()
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
      vim.cmd.hi 'String gui=none'
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('rose-pine').setup {
        variant = 'main',
        dark_variant = 'main',
        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },
      }

      vim.cmd.hi 'Comment gui=none'
      vim.cmd.hi 'String gui=none'
    end,
  },
  {
    'scottmckendry/cyberdream.nvim',
    name = 'cyberdream',
    lazy = false,
    priority = 1000,
    config = function()
      require('cyberdream').setup {
        transparent = true,
      }
      vim.cmd.hi 'Comment gui=none'
      vim.cmd.hi 'String gui=none'
    end,
  },
  {
    'loctvl842/monokai-pro.nvim',
    name = 'monokai-pro',
    lazy = false,
    priority = 1000,
    config = function()
      require('monokai-pro').setup {
        transparent_background = true,
        inc_search = 'background',
        background_clear = {
          'float_win',
          'toggleterm',
          'telescope',
          'which-key',
          'cmp_menu',
        },
        override = function()
          return {
            ['@markup.raw.block.markdown'] = { bg = 'NONE' },
          }
        end,
      }
    end,
  },
}
