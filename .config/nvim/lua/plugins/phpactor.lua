return {
  'phpactor/phpactor',
  ft = 'php',
  build = 'composer install --no-dev --optimize-autoloader',
  keys = {
    -- { 'gd', '<cmd>PhpactorGotoDefinition<cr>', desc = 'Goto Definition', ft = 'php' },
    -- { 'K', '<cmd>PhpactorHover<cr>', desc = 'Hover', ft = 'php' },
    -- { 'gr', '<cmd>PhpactorFindReferences<cr>', desc = 'Find References', ft = 'php' },
    { '<leader>pm', '<cmd>PhpactorContextMenu<cr>', desc = 'Phpactor Menu', ft = 'php' },
    { '<leader>pc', '<cmd>PhpactorCopyClass<cr>', desc = 'Phpactor copy class', ft = 'php' },
    { '<leader>pi', '<cmd>PhpactorImportClass<cr>', desc = 'Phpactor import Class', ft = 'php' },
    { '<leader>pu', '<cmd>PhpactorImportMissingClasses<cr>', desc = 'Phpactor import missing Class', ft = 'php' },
    -- { '<leader>pem', '<cmd>PhpactorExtractMethod<cr>', desc = 'Extract Method', ft = 'php', mode = 'v' },
    -- { '<leader>pec', '<cmd>PhpactorExtractConstant<cr>', desc = 'Extract Constant', ft = 'php' },
    -- { '<leader>pee', '<cmd>PhpactorExtractExpression<cr>', desc = 'Extract Expression', ft = 'php', mode = 'v' },
  },
  -- init = function()
  --   vim.g.phpactorPhpBin = 'php'
  -- end,
}
