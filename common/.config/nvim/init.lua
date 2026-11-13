vim.loader.enable()

-- [[ Leader / globals ]]
-- leader は plugin や keymap より前に決める
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- [[ Options ]]
vim.o.shell = 'zsh'
vim.o.linebreak = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.listchars = 'tab:» ,trail:·,nbsp:␣'
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.clipboard = 'unnamedplus'
vim.o.showmode = false
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- [[ Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', 'x', '"_x', { silent = true })

-- [[ Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Plugins ]]

-- PackChanged のフックは、そのプラグインを入れうる vim.pack.add より前に定義する
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then
      return
    end

    if name == 'nvim-treesitter' then
      if not ev.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
    elseif name == 'telescope-fzf-native.nvim' then
      local result = vim.system({ 'make' }, { cwd = ev.data.path }):wait()
      if result.code ~= 0 then
        vim.notify(
          'Build failed for ' .. name .. ':\n' .. (result.stderr or ''),
          vim.log.levels.ERROR
        )
      end
    end
  end,
})

-- telescope
local telescope_plugins = {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
}
if vim.fn.executable('make') == 1 then
  table.insert(telescope_plugins, 'https://github.com/nvim-telescope/telescope-fzf-native.nvim')
end
vim.pack.add(telescope_plugins)

require('telescope').setup({
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
})
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set(
  { 'n', 'v' },
  '<leader>sw',
  builtin.grep_string,
  { desc = '[S]earch current [W]ord' }
)
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files({ cwd = vim.fn.stdpath('config'), follow = true })
end, { desc = '[S]earch [N]eovim files' })

-- yazi
vim.pack.add({ 'https://github.com/mikavilpas/yazi.nvim' })

vim.g.loaded_netrwPlugin = 1
require('yazi').setup({
  open_for_directories = true,
})

vim.keymap.set(
  { 'n', 'v' },
  '<leader>e',
  '<cmd>Yazi<cr>',
  { desc = 'Open yazi at the current file' }
)
vim.keymap.set(
  'n',
  '<leader>E',
  '<cmd>Yazi cwd<cr>',
  { desc = 'Open yazi in the working directory' }
)

-- colorscheme
vim.pack.add({
  { src = 'https://github.com/folke/tokyonight.nvim' },
})
vim.cmd.colorscheme('tokyonight-night')

-- treesitter
vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

local parsers = {
  'bash',
  'zsh',
  'c',
  'cpp',
  'css',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'rust',
  'vim',
  'vimdoc',
  'ini',
  'gitignore',
  'json',
}
require('nvim-treesitter').install(parsers)
vim.treesitter.language.register('bash', 'zsh')

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang then
      return
    end
    if not vim.treesitter.language.add(lang) then
      return
    end
    vim.treesitter.start(args.buf, lang)

    if vim.treesitter.query.get(lang, 'indents') then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- treesitter を前提にするプラグイン
vim.pack.add({
  { src = 'https://github.com/HiPhish/rainbow-delimiters.nvim' },
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
})
require('nvim-ts-autotag').setup()

-- lsp
vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
})
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
})
vim.lsp.config('clangd', {
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=never',
  },
})

-- 名前: lspconfig の設定名 = 実行ファイル名
local servers = {
  clangd = 'clangd',
  html = 'vscode-html-language-server',
  cssls = 'vscode-css-language-server',
  lua_ls = 'lua-language-server',
  emmet_language_server = 'emmet-language-server',
  rust_analyzer = 'rust-analyzer',
  ruff = 'ruff',
}
local enabled_servers = {}
for name, bin in pairs(servers) do
  if vim.fn.executable(bin) == 1 then
    table.insert(enabled_servers, name)
  end
end
vim.lsp.enable(enabled_servers)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('grr', builtin.lsp_references, '[G]oto [R]eferences')
    map('gri', builtin.lsp_implementations, '[G]oto [I]mplementation')
    map('grd', builtin.lsp_definitions, '[G]oto [D]efinition')
    map('grt', builtin.lsp_type_definitions, '[G]oto [T]ype Definition')
    map('gO', builtin.lsp_document_symbols, 'Open Document Symbols')
    map('gW', builtin.lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
  end,
})

vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = { -- インライン
    prefix = '●', -- 先頭の記号
    spacing = 2, -- コードとの間隔
    source = 'if_many',
  },
  signs = true, 
  virtual_lines = false, -- 下に注釈
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      })
    end,
  },
})

vim.keymap.set(
  'n',
  '<leader>q',
  vim.diagnostic.setloclist,
  { desc = 'Open diagnostic [Q]uickfix list' }
)

-- formatting
vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

require('conform').setup({
  formatters_by_ft = {
    cpp = { 'clang_format' },
    c = { 'clang_format' },
    python = { 'ruff_organize_imports', 'ruff_format' },
    rust = { 'rustfmt' },
    html = { 'prettier' },
    css = { 'prettier' },
    lua = { 'stylua' },
  },
  default_format_opts = { lsp_format = 'fallback' }, -- 未定義の言語は LSP に任せる
})

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format({ async = true })
end, { desc = '[F]ormat buffer or selection' })

-- dap
vim.pack.add({
  'https://github.com/mfussenegger/nvim-dap',
})

local dap = require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-dap',
  name = 'lldb',
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP: continue / start' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP: step over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP: step into' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'DAP: toggle [b]reakpoint' })

-- completion
vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
})

-- 独自の設定を足す場合はここに書く
require('blink.cmp').setup({})

-- dap-ui
vim.pack.add({
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/rcarriga/nvim-dap-ui',
})

local dapui = require('dapui')
dapui.setup()

-- デバッグの開始/終了に合わせて UI を開閉
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = '[D]ebug: toggle [u]i' })
vim.keymap.set({ 'n', 'v' }, '<leader>de', dapui.eval, { desc = '[D]ebug: [e]val expression' })

-- gitsigns
vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

local gitsigns = require('gitsigns')
gitsigns.setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end, 'Jump to next git [c]hange')

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end, 'Jump to previous git [c]hange')

    map('n', '<leader>hs', gitsigns.stage_hunk, 'git [s]tage hunk')
    map('n', '<leader>hr', gitsigns.reset_hunk, 'git [r]eset hunk')
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'git [s]tage hunk')
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'git [r]eset hunk')
    map('n', '<leader>hp', gitsigns.preview_hunk, 'git [p]review hunk')
    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end, 'git [b]lame line')
    map('n', '<leader>hd', gitsigns.diffthis, 'git [d]iff against index')
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, '[T]oggle git show [b]lame line')
  end,
})

-- which-key
vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

require('which-key').setup({
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
  },
})

-- UI の補助
vim.pack.add({
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
})

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
  vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
  vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
  vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
  vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
  vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
  vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
  vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
end)

require('ibl').setup({
  indent = { highlight = highlight },
  scope = { enabled = false },
})

-- 日本語入力補助
--   Mac : macism（Brewfile で導入）
--   Linux: fcitx5-remote（fcitx5 で導入）
vim.pack.add({ 'https://github.com/keaising/im-select.nvim' })
if vim.uv.os_uname().sysname == 'Darwin' then
  require('im_select').setup({
    default_command = 'macism',
    default_im_select = 'com.apple.keylayout.ABC',
    keep_quiet_on_no_binary = true,
  })
else
  require('im_select').setup({
    default_command = 'fcitx5-remote',
    default_im_select = 'keyboard-us',
    keep_quiet_on_no_binary = true,
  })
end
