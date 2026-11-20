-- [[ LeetCode ]]
-- INFO: start with `nvim leetcode.nvim`, or `:Leet` in an empty session
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/kawre/leetcode.nvim',
})

require('leetcode').setup({
  lang = 'cpp',
  storage = {
    home = vim.fn.expand('~/leetcode')
  },
  picker = { provider = 'telescope' },
  image_support = true,
})

