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

local function set_desc(modes, lhs, desc)
  local key = lhs:gsub('<[Ll]eader>', vim.g.mapleader or '\\')
  for _, mode in ipairs(modes) do
    local m = vim.fn.maparg(key, mode, false, true)
    if not vim.tbl_isempty(m) then
      vim.keymap.set(mode, key, m.callback or m.rhs, {
        expr = m.expr == 1,
        silent = m.silent == 1,
        nowait = m.nowait == 1,
        noremap = m.noremap == 1,
        desc = desc,
      })
    end
  end
end

set_desc({ 'n', 'x' }, 'ga', 'Align: Start')
set_desc({ 'n', 'x' }, 'gA', 'Align: Start with preview')

require('mini.pairs').setup()
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  MiniIcons.mock_nvim_web_devicons()
end
require('mini.starter').setup()
require('mini.surround').setup({
  mappings = {
  add = '<leader>ua',
    delete = '<leader>ud',
    find = '<leader>uf',
    find_left = '<leader>uF',
    highlight = '<leader>uh',
    replace = '<leader>ur',
    suffix_last = 'l',
    suffix_next = 'n'
  },
})

local function set_desc(mode, lhs, desc)
  local m = vim.fn.maparg(lhs, mode, false, true)
  if vim.tbl_isempty(m) then return end
  vim.keymap.set(mode, lhs, m.callback or m.rhs, {
    expr = m.expr == 1,
    silent = m.silent == 1,
    desc = 'Surround: ' .. desc,
  })
end

set_desc('n', '<leader>ua', 'add')
set_desc('x', '<leader>ua', 'Add (selection)')
set_desc('n', '<leader>ud', 'Delete')
set_desc('n', '<leader>ur', 'Replace')
set_desc('n', '<leader>uf', 'Find right')
set_desc('n', '<leader>uF', 'Find left')
set_desc('n', '<leader>uh', 'Highlight')
set_desc('n', '<leader>un', 'Update n_lines')
-- TODO: mini.ai comming soon...
-- require('mini.ai').setup()
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
