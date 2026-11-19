-- [[ Format ]]
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
    nix = { 'nixfmt' },
  },
  default_format_opts = { lsp_format = 'fallback' }, -- fallback to LSP servers if file is undefined
})

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format({ async = true })
end, { desc = 'Format: buffer or selection' })
