return {
  -- Try UTF-8 encoding (Intelephense may not follow LSP spec default)
  offset_encoding = 'utf-8',
  on_attach = function(client)
    -- Disable features handled by phpactor vim plugin
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.definitionProvider = false
    client.server_capabilities.referencesProvider = false
  end,
}
