-- [[ Global ]]
-- INFO: set <leader> before plugins and keymaps (it expands when a mapping is defined)
vim.g.mapleader = ' '        -- <leader> set to space key
vim.g.maplocalleader = ' '   -- <localleader> set to space key
vim.g.have_nerd_font = true  -- nerd_font enabled
vim.g.loaded_netrwPlugin = 1 -- netrwPlugin disable (for yazi)
-- hledger integration
vim.filetype.add({
  extension = {
    journal = "hledger",
    hledger = "hledger",
    prices = "hledger",
  },
})

-- [[ Options ]]
vim.o.shell = 'zsh'                       -- use zsh
vim.o.linebreak = true                    -- wrap at word boundaries
vim.o.number = true                       -- show absolute number on current line
vim.o.relativenumber = true               -- show relative line number
vim.o.mouse = ''                          -- disable mouse
vim.o.breakindent = true                  -- keep indent on wrapped lines
vim.o.undofile = true                     -- save undo history
vim.o.ignorecase = true                   -- ignore case when searching
vim.o.smartcase = true                    -- case-sensitive if search has uppercase
vim.o.signcolumn = 'yes'                  -- always show sign space
vim.o.updatetime = 250                    -- idle time (ms) before swap write and cursorhold
vim.o.timeoutlen = 300                    -- wait time (ms) for mapped key sequence
vim.o.splitright = true                   -- :vsplit to the right
vim.o.splitbelow = true                   -- :split below
vim.o.list = true                         -- show invisible text
vim.o.listchars = 'tab:» ,trail:·,nbsp:␣' -- invisible text style
vim.o.inccommand = 'split'                -- live preview for :s
vim.o.cursorline = true                   -- highlight where cursor is
vim.o.scrolloff = 10                      -- keep 10 lines around cursor
vim.o.confirm = true                      -- ask to save instead of failing on :q
vim.o.clipboard = 'unnamedplus'           -- share yank with system clipboard
vim.o.showmode = false                    -- hide mode text (for lualine)
vim.o.expandtab = true                    -- <tab>key inserts space instead of a tab character
vim.o.softtabstop = 2                     -- <tab>/<BS> moves two columns
vim.o.tabstop = 2                         -- display width of a tab character
vim.o.shiftwidth = 2                      -- auto indent, <<, >> width set to two


