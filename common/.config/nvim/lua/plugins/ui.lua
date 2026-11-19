-- [[ UI ]]
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
})
require('mini.align').setup()

require('mini.pairs').setup()
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  MiniIcons.mock_nvim_web_devicons()
end
require('guess-indent').setup({})
require('todo-comments').setup({ signs = false })
require('fidget').setup({})
require('lualine').setup({
  options = {
    theme = 'auto',
    icons_enabled = vim.g.have_nerd_font,
    component_separators = '|',
    section_separators = { left = vim.fn.nr2char(0xe0b0), right = vim.fn.nr2char(0xe0b2) },
  },
  sections = {
    lualine_c = { { 'filename', path = 1 } },
  },
})
local highlight = {
  'RainbowRed',
  'RainbowYellow',
  'RainbowBlue',
  'RainbowOrange',
  'RainbowGreen',
  'RainbowViolet',
  'RainbowCyan',
}

local hooks = require('ibl.hooks')
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#e06c75' })
  vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#e5c07b' })
  vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61afef' })
  vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#d19a66' })
  vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98c379' })
  vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#c678dd' })
  vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56b6c2' })
end)

require('ibl').setup({
  indent = { highlight = highlight },
  scope = { enabled = false },
})
