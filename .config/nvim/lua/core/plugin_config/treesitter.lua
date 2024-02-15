require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  -- ensure_installed = { "c", "lua", "rust", "ruby", "vim"},
  ensure_installed = {"c", "lua", "php", "typescript", "twig", "tsx", "vim", "yaml", "scss", "regex", "python", "json", "html", "javascript", "css"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
