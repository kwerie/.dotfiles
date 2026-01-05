return {
  {
    'ellisonleao/gruvbox.nvim',
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
          transparency = false,
        },
      }

      -- TODO: move this elsewhere
      -- Set the colorscheme
      --vim.cmd 'colorscheme rose-pine'
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
      vim.cmd 'colorscheme cyberdream'
      vim.cmd.hi 'Comment gui=none'
      vim.cmd.hi 'String gui=none'
    end,
  },
}
