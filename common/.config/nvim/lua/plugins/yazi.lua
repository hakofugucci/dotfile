-- [[ Yazi ]]
vim.pack.add({ 'https://github.com/mikavilpas/yazi.nvim' })

require('yazi').setup({
  open_for_directories = false,
})

vim.keymap.set(
  { 'n', 'v' },
  '<leader>e',
  '<cmd>Yazi<cr>',
  { desc = 'Yazi: open yazi at the current file' }
)
vim.keymap.set(
  'n',
  '<leader>E',
  '<cmd>Yazi cwd<cr>',
  { desc = 'Yazi: open yazi in the working directory' }
)
