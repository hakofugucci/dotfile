-- which-key
vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

require('which-key').setup({
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>h', group = 'Git hunk', mode = { 'n', 'v' } },
    { '<leader>t', group = 'Toggle' },
    { '<leader>s', group = 'Search', mode = { 'n', 'v' } },
    { '<leader>g', group = 'Git', mode = { 'n', 'v' } },
    { '<leader>d', group = 'Debug', mode = { 'n', 'v' } },
    { '<leader>x', group = 'Diagnostics', mode = { 'n' } },
    { 'gr', group = 'Lsp actions', mode = { 'n' } },
    -- { '<leader>m', group = 'Make', mode = { 'n' } },
    -- { '<leader>n', group = 'Note', mode = { 'n' } },
    -- { '<leader>c', group = 'Code', mode = { 'n' } },
  },
})

vim.keymap.set('n', '<leader>?', function()
  require('which-key').show({ global = false })
end, { desc = 'Keymaps: buffer-local' })
