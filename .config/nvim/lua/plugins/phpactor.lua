return {
  'phpactor/phpactor',
  ft = 'php',
  build = 'composer install --no-dev --optimize-autoloader',
  keys = {
    { 'gd', '<cmd>PhpactorGotoDefinition<cr>', desc = 'Goto Definition', ft = 'php' },
    { 'K', '<cmd>PhpactorHover<cr>', desc = 'Hover', ft = 'php' },
    { 'gr', '<cmd>PhpactorFindReferences<cr>', desc = 'Find References', ft = 'php' },
    { '<leader>pm', '<cmd>PhpactorContextMenu<cr>', desc = 'Phpactor Menu', ft = 'php' },
    { '<leader>pn', '<cmd>PhpactorClassNew<cr>', desc = 'New Class', ft = 'php' },
    { '<leader>prv', '<cmd>PhpactorChangeVisibility<cr>', desc = 'Change Visibility', ft = 'php' },
    { '<leader>prn', '<cmd>PhpactorMoveFile<cr>', desc = 'Rename/Move File', ft = 'php' },
    { '<leader>pt', '<cmd>PhpactorTransform<cr>', desc = 'Phpactor Transform', ft = 'php' },
    { '<leader>pr', '<cmd>PhpactorContextMenu<cr>', desc = 'Phpactor Refactor', ft = 'php' },
    { '<leader>pci', '<cmd>PhpactorClassInflect<cr>', desc = 'Class Inflect', ft = 'php' },
    { '<leader>pim', '<cmd>PhpactorImportClass<cr>', desc = 'Import Class', ft = 'php' },
    { '<leader>pem', '<cmd>PhpactorExtractMethod<cr>', desc = 'Extract Method', ft = 'php', mode = 'v' },
    { '<leader>pec', '<cmd>PhpactorExtractConstant<cr>', desc = 'Extract Constant', ft = 'php' },
    { '<leader>pee', '<cmd>PhpactorExtractExpression<cr>', desc = 'Extract Expression', ft = 'php', mode = 'v' },
  },
  init = function()
    vim.g.phpactorPhpBin = 'php'
  end,
}
