-- [[ Completion ]]
-- INFO: pinned to 1.* (stable)
vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/disrupted/blink-cmp-conventional-commits',
})

require('blink.cmp').setup({
  keymap = {
    preset = 'default', -- accept with <C-y> (not <tab>)
  },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 300 },
    menu = {
      border = 'rounded',
      draw = { treesitter = { 'lsp' } },
      auto_show = function() -- no automatic menu while writing prose in markdown
        return vim.bo.filetype ~= 'markdown'
      end,
    },
    ghost_text = { enabled = true },
  },

  signature = { enabled = true, window = { border = 'rounded' } },

  sources = { -- suggestion sources
    default = { 'conventional_commits', 'lsp', 'path', 'snippets', 'buffer' },
    providers = { -- commit-message completion
      conventional_commits = {
        name = 'Conventional commits',
        module = 'blink-cmp-conventional-commits',
        enabled = function()
          return vim.bo.filetype == 'gitcommit'
        end,
        opts = {
          completion = {
            items = {
              -- if you want to add custom commit type, use here ({ type = '', doc = '' },)
            },
          },
        },
      },
    },
  },

  fuzzy = {
    implementation = 'prefer_rust_with_warning', -- use the Rust matcher, fall back to Lua with a warning
    sorts = { -- suggestion priority (same as the default)
      'exact',
      'score',
      'sort_text',
    },
  },
})

-- pass blink capabilities to LSP servers (for safety, before vim.lsp.enable)
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})
