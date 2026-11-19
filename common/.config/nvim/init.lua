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
require('plugins.completion')
require('plugins.lsp')
require('plugins.diagnostics')
require('plugins.format')
require('plugins.git')
require('plugins.yazi')
require('plugins.dap')
require('plugins.ui')
require('plugins.oil')

-- [[ visual ]]
require('plugins.which-key')
require('plugins.smear-cursor')
require('plugins.im-select')
