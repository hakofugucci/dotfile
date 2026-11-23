-- [[ Telescope ]]
local telescope_plugins = {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
}
if vim.fn.executable('make') == 1 then
  table.insert(telescope_plugins, 'https://github.com/nvim-telescope/telescope-fzf-native.nvim')
end
vim.pack.add(telescope_plugins)

local telescope = require('telescope')
telescope.setup({
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
})
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sl', builtin.help_tags, { desc = 'Search: help tags' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search: keymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search: files' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search: telescope pickers' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = 'Search: current word' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search: live grep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search: diagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search: resume last picker' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search: recent files' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = 'Search: commands' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Search: buffers' })
vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = 'Search: fuzzy find in current buffer' })
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files({ cwd = vim.fn.stdpath('config'), follow = true })
end, { desc = 'Search: neovim config files' })
vim.keymap.set('n', '<leader>shf', builtin.git_files, { desc = 'Search: files' })
vim.keymap.set('n', '<leader>shs', builtin.git_status, { desc = 'Search: status (telescope)' })
vim.keymap.set('n', '<leader>shb', builtin.git_branches, { desc = 'Search: branches' })
vim.keymap.set('n', '<leader>shl', builtin.git_commits, { desc = 'Search: commits' })
vim.keymap.set('n', '<leader>shL', builtin.git_bcommits, { desc = 'Search: buffer commits' })
