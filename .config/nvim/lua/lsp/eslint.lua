return {
  settings = {
    workingDirectories = { mode = 'auto' },
    format = auto_format,
  },
  -- Disable pull diagnostics: the server's JSON.stringify of the flat config
  -- hits a circular ref in eslint-plugin-react (via next/core-web-vitals).
  -- Push diagnostics still work.
  on_init = function(client)
    client.server_capabilities.diagnosticProvider = nil
  end,
}
