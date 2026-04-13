function SetColorScheme()
  vim.cmd 'colorscheme gruber-darker'
end

return {
  {
    'ellisonleao/gruvbox.nvim',
    name = 'gruvbox',
    config = function()
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
      vim.cmd.hi 'String gui=none'
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        variant = 'main',
        dark_variant = 'main',
        styles = {
          bold = true,
          italic = false,
          -- transparency = true,
        },
      }

      vim.cmd.hi 'Comment gui=none'
      vim.cmd.hi 'String gui=none'
    end,
  },
  {
    'scottmckendry/cyberdream.nvim',
    name = 'cyberdream',
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
  {
    'folke/tokyonight.nvim',
    name = 'tokyonight',
    opts = {
      style = 'night',
    },
  },
  {
    'kwerie/gruber-darker.nvim',
    name = 'gruber-darker',
    opts = {
      italic = {
        strings = false,
        comments = true,
        operators = false,
        folds = true,
      },
    },
  },
}
