-- [[ terminal ]]
vim.pack.add({'https://github.com/akinsho/toggleterm.nvim'})

require('toggleterm').setup({
  open_mapping = [[<C-¥>]],
  direction = 'float',
  float_opts = { border = 'rounded' },
  shade_terminals = false,
  start_in_insert = true,
  close_on_exit = true,
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return math.floor(vim.o.columns * 0.4)
    end
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*toggleterm#*',
  callback = function(ev)
    local o = function(desc) return { buffer = ev.buf, desc = 'Term: ' .. desc } end
    vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], o('normal mode'))
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], o('left window'))
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], o('down window'))
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], o('up window'))
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], o('right window'))
  end,
})
