-- [[ Oil ]]
vim.pack.add({ 'https://github.com/stevearc/oil.nvim' })

local function oil_desc(desc)
  return 'Oil: ' .. desc
end
require('oil').setup({
  default_file_explorer = true,
  columns = {
    'icon',
  },
  buf_options = {
    buflisted = false,
    bufhidden = 'hide',
  },
  win_options = {
    wrap = false,
    signcolumn = 'no',
    cursorcolumn = false,
    foldcolumn = '0',
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = 'nvic',
  },
  delete_to_trash = true,
  skip_confirm_for_simple_edits = false,
  prompt_save_on_select_new_entry = true,
  cleanup_delay_ms = 2000,
  lsp_file_methods = {
    enabled = true,
    timeout_ms = 1000,
    autosave_changes = false,
  },
  constrain_cursor = 'editable',
  watch_for_changes = false,
  keymaps = {
    ['<F1>'] = { 'actions.show_help', mode = 'n', desc = oil_desc('help') },
    ['<CR>'] = { 'actions.select', desc = oil_desc('select/open') },
    ['<C-v>'] = { 'actions.select', desc = oil_desc('open vertical'), opts = { vertical = true } },
    ['<C-x>'] = { 'actions.select', desc = oil_desc('open horizontal'), opts = { horizontal = true } },
    ['<C-t>'] = { 'actions.select', desc = oil_desc('open tab'), opts = { tab = true } },
    ['<C-p>'] = { 'actions.preview', desc = oil_desc('preview') },
    ['<C-c>'] = { 'actions.close', mode = 'n', desc = oil_desc('close') },
    ['<C-r>'] = { 'actions.refresh', desc = oil_desc('refresh') },
    ['-'] = { 'actions.parent', mode = 'n', desc = oil_desc('go parent') },
    ['_'] = { 'actions.open_cwd', mode = 'n', desc = oil_desc('back to :pwd') },
    ['`'] = { 'actions.cd', mode = 'n', desc = oil_desc('cd') },
    ['g~'] = { 'actions.cd', mode = 'n', desc = oil_desc(':cd'), opts = { scope = 'tab' } },
    ['gs'] = { 'actions.change_sort', mode = 'n', desc = oil_desc('change sort') },
    ['gx'] = { 'actions.open_external', desc = oil_desc('open external') },
    ['g.'] = { 'actions.toggle_hidden', mode = 'n', desc = oil_desc('toggle hidden') },
    ['g\\'] = { 'actions.toggle_trash', mode = 'n', desc = oil_desc('toggle trash') },
    ['<leader>sF'] = {
      function()
        require('telescope.builtin').find_files({
          cwd = require('oil').get_current_dir(),
        })
      end,
      mode = 'n',
      desc = oil_desc('files in current dir'),
    },
  },
  use_default_keymaps = false,
  view_options = {
    show_hidden = false,
    natural_order = 'fast',
    case_insensitive = false,
  },
})

vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = oil_desc('open parent directory') })
