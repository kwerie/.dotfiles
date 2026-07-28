-- vscode-css-language-server (cssls)
--
-- Coexists with the tailwindcss LSP:
--   * Formatting is disabled here so prettier (via conform) owns it. cssls's own
--     formatter mangles Tailwind v4 syntax (e.g. the `!` important suffix).
--   * Unknown at-rules are ignored so Tailwind directives (@apply, @tailwind,
--     @screen, @variants, ...) don't produce false-positive warnings in .scss/.css.
local lint = { unknownAtRules = 'ignore' }

return {
  filetypes = { 'css', 'scss', 'less' },
  on_attach = function(client)
    -- prettier owns formatting; prevent cssls from competing (e.g. on `gq`,
    -- range format, or any lsp_format fallback path).
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  settings = {
    css = {
      validate = true,
      lint = lint,
    },
    less = {
      validate = true,
      lint = lint,
    },
    scss = {
      validate = true,
      lint = lint,
    },
  },
}
