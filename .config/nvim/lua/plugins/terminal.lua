local get_root = function()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if vim.v.shell_error == 0 and git_root ~= '' then
    return git_root
  end
  return vim.fn.getcwd()
end

return {
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    cmd = { 'ToggleTerm' },
    keys = {
      {
        '<leader>Tf',
        function()
          local count = vim.v.count1
          require('toggleterm').toggle(count, 0, get_root(), 'float')
        end,
        desc = 'ToggleTerm (float root_dir)',
      },
      {
        '<leader>Th',
        function()
          local count = vim.v.count1
          require('toggleterm').toggle(count, 15, get_root(), 'horizontal')
        end,
        desc = 'ToggleTerm (horizontal root_dir)',
      },
      {
        '<leader>Tv',
        function()
          local count = vim.v.count1
          require('toggleterm').toggle(count, vim.o.columns * 0.4, get_root(), 'vertical')
        end,
        desc = 'ToggleTerm (vertical root_dir)',
      },
      {
        '<leader>Tn',
        '<cmd>ToggleTermSetName<cr>',
        desc = 'Set term name',
      },
      {
        '<leader>Ts',
        '<cmd>TermSelect<cr>',
        desc = 'Select term',
      },
      {
        '<leader>Tt',
        function()
          require('toggleterm').toggle(1, 100, get_root(), 'tab')
        end,
        desc = 'ToggleTerm (tab root_dir)',
      },
      {
        '<leader>TT',
        function()
          require('toggleterm').toggle(1, 100, vim.loop.cwd(), 'tab')
        end,
        desc = 'ToggleTerm (tab cwd_dir)',
      },
    },
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = 'horizontal',
      close_on_exit = true,
    },
  },
}
