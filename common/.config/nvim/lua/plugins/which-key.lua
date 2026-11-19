-- which-key
vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

require('which-key').setup({
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>h', group = 'git hunk', mode = { 'n', 'v' } },
    { '<leader>t', group = 'toggle' },
    { '<leader>s', group = 'search', mode = { 'n', 'v' } },
    { '<leader>g', group = 'git', mode = { 'n' } },
    { '<leader>d', group = 'debug', mode = { 'n' } },
    { '<leader>x', group = 'diagnostics', mode = { 'n' } },
    {        'gr', group = 'lsp actions', mode = { 'n' } },
    -- { '<leader>m', group = 'make', mode = { 'n' } },
    -- { '<leader>n', group = 'note', mode = { 'n' } },
    -- { '<leader>c', group = 'code', mode = { 'n' } },
  },
})

vim.keymap.set('n', '<leader>?', function()
  require('which-key').show({ global = false })
end, { desc = 'Keymaps: buffer-local' })

