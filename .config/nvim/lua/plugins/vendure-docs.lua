return {
  'kwerie/vendure-docs-browser.nvim',
  version = 'v1.0.0',
  -- dir = '~/Projects/kwerie/vendure-docs-browser.nvim',
  config = function()
    local vendure_docs_plugin = require 'vendure-docs-browser'

    vendure_docs_plugin.setup {}

    vim.api.nvim_set_keymap('n', '<leader>vd', ':BrowseVendureDocs<CR>', { noremap = true, silent = true })
  end,
}
