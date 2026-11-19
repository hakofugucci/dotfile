-- [[ Diagnostic ]]
vim.keymap.set(
  'n',
  '<leader>xl',
  vim.diagnostic.setloclist,
  { desc = 'Diagnostics: location list' }
)

vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = { -- inline text
    prefix = '●',
    spacing = 2,
    source = 'if_many',
  },
  signs = true,
  virtual_lines = false, -- below on line (disabled)
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
