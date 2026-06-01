return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = {
          c = true,
        }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          -- php-cs-fixer / phpcbf can be slow on first run
          timeout_ms = vim.bo[bufnr].filetype == 'php' and 5000 or 1000,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier' },
        -- Each php formatter is gated on its config file (see `formatters` below).
        -- If neither matches, both are skipped and lsp_format='fallback' runs intelephense.
        php = { 'php_cs_fixer', 'phpcbf', stop_after_first = true },
      },
      formatters = {
        php_cs_fixer = {
          -- Bypass PHP version check (the tool may not officially support newer PHP versions yet).
          env = { PHP_CS_FIXER_IGNORE_ENV = '1' },
          condition = function(_, ctx)
            return vim.fs.find({
              '.php-cs-fixer.php',
              '.php-cs-fixer.dist.php',
            }, { path = ctx.dirname, upward = true, type = 'file' })[1] ~= nil
          end,
        },
        phpcbf = {
          condition = function(_, ctx)
            return vim.fs.find({
              'phpcs.xml',
              'phpcs.xml.dist',
              '.phpcs.xml',
              '.phpcs.xml.dist',
            }, { path = ctx.dirname, upward = true, type = 'file' })[1] ~= nil
          end,
        },
      },
    },
  },
}
