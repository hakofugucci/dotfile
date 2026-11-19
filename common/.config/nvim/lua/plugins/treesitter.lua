-- [[ Treesitter ]]
vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' }, -- main branch is the rewrite; legacy master is no longer developed
})

-- parsers install
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

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
  desc = 'Start treesitter and set indentexpr per filetype',
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

-- depend on treesitter
vim.pack.add({
  'https://github.com/HiPhish/rainbow-delimiters.nvim',
  'https://github.com/windwp/nvim-ts-autotag',
})
require('nvim-ts-autotag').setup()
