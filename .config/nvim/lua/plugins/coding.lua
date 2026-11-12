return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'jparise/vim-graphql', -- Syntax highlighting for GraphQL files
  {
    'seblyng/roslyn.nvim',
    ft = 'cs',
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {},
  },
  {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    ft = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' },
    opts = {
      lsp = {
        enabled = false,
      },
      auto_bootstrap_namespace = {
        --block_scoped, file_scoped
        type = 'file_scoped',
        enabled = true,
        use_clipboard_json = {
          behavior = 'prompt', --'auto' | 'prompt' | 'never',
          register = '+', -- which register to check
        },
      },
    },
  },
  {
    'towolf/vim-helm',
    ft = { 'helm' },
  },
}
