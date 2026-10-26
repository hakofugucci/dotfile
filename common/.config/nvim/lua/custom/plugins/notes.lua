vim.pack.add {
  'https://github.com/zk-org/zk-nvim',
  'https://github.com/oflisback/obsidian-bridge.nvim',
  'https://github.com/zk-org/zk-nvim',
  'https://github.com/oflisback/obsidian-bridge.nvim',
  'https://github.com/keaising/im-select.nvim',

}

require('zk').setup()
require('obsidian-bridge').setup()
require('im_select').setup {}
require('obsidian-bridge').setup { scroll_sync = true }
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  pattern = vim.fn.expand '~/vault' .. '/*.md',
  callback = function()
    if vim.bo.modifiable and vim.bo.modified then
      vim.cmd 'silent! write'
    end
  end,
})
