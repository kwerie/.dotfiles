local M = {}

-- LSP attach autocommand
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- LSP keymaps
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Document highlight
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- Inlay hints toggle
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Diagnostic configuration
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    -- Skip if a floating window is already open
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative ~= '' then
        return
      end
    end
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      border = 'rounded',
      source = 'always',
      prefix = '',
      scope = 'cursor',
    })
  end,
})

vim.diagnostic.config {
  update_in_insert = false,
  underline = true,
  virtual_lines = false,
}

-- Setup function
function M.setup()
  -- LSP capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

  -- Load all LSP server configurations
  local servers = {
    gopls = require 'lsp.gopls',
    ts_ls = require 'lsp.ts_ls',
    jsonls = require 'lsp.jsonls',
    dockerls = require 'lsp.dockerls',
    docker_compose_language_service = require 'lsp.docker_compose',
    eslint = require 'lsp.eslint',
    omnisharp = require 'lsp.omnisharp',
    pyright = require 'lsp.pyright',
    intelephense = require 'lsp.intelephense',
    lua_ls = require 'lsp.lua_ls',
    helm_ls = require 'lsp.helm_ls',
    twiggy_language_server = require 'lsp.twig',
    yamlls = require 'lsp.yamlls',
    clangd = {},
  }

  -- Setup Mason
  require('mason').setup()

  -- Tools to ensure installed
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    'stylua',
    'prettier',
    'hadolint',
  })
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  -- Setup mason-lspconfig (for automatic server installation)
  require('mason-lspconfig').setup()

  -- Configure LSP servers using vim.lsp.config (Neovim 0.11+)
  for server_name, server_config in pairs(servers) do
    local config = vim.tbl_deep_extend('force', {}, server_config)
    config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
    vim.lsp.config(server_name, config)
  end

  -- Enable all configured servers
  vim.lsp.enable(vim.tbl_keys(servers))
end

return M
