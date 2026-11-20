vim.loader.enable()

-- [[ configs ]]
require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.pack')

-- [[ Plugins ]]
require('plugins.colorscheme') -- visual
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.completion') -- INFO: before plugins.lsp
require('plugins.lsp')
require('plugins.diagnostics')
require('plugins.format')
require('plugins.git')
require('plugins.yazi')
require('plugins.dap')
require('plugins.ui')
require('plugins.oil')
require('plugins.terminal')
require('plugins.leetcode')

-- [[ visual ]]
require('plugins.which-key')
require('plugins.smear-cursor')
require('plugins.image')

-- [[ misc ]]
require('plugins.im-select')
