return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'jparise/vim-graphql', -- Syntax highlighting for GraphQL files
  {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('easy-dotnet').setup()
    end,
  },
  {
    'towolf/vim-helm',
    ft = { 'helm' },
  },
}
