return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function(plugin)
      vim.opt.rtp:prepend(plugin.dir .. '/runtime')
      require('nvim-treesitter').setup()

      local parsers = {
        'bash',
        'c',
        'cpp',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'php',
        'c_sharp',
        'helm',
        'yaml',
        'gotmpl',
        'dockerfile',
        'twig',
        'glimmer',
      }
      require('nvim-treesitter').install(parsers)

      -- Languages whose treesitter indent queries are missing/incomplete on the
      -- `main` branch. Neovim's built-in indent files (runtime/indent/*.vim) do a
      -- better job, so we keep treesitter highlighting but leave indentexpr alone.
      local indentexpr_blocklist = {
        css = true,
        scss = true,
        less = true,
      }

      local function treesitter_try_attach(buf, language)
        if not vim.treesitter.language.add(language) then
          return
        end
        vim.treesitter.start(buf, language)
        if not indentexpr_blocklist[language] then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      local available_parsers = require('nvim-treesitter').get_available()

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match
          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

          if vim.tbl_contains(installed_parsers, language) then
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            require('nvim-treesitter').install(language):await(function()
              treesitter_try_attach(buf, language)
            end)
          else
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },
}
