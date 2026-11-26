-- [[ LSP ]]
vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

-- lua_ls config
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

-- clangd config
vim.lsp.config('clangd', {
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=never',
    -- INFO: nix compilers live in hash-named store paths; clangd only queries
    -- drivers matching this glob to find the std headers (breaks for gcc)
    '--query-driver=/nix/store/*/bin/clang*',
    -- INFO: relative path; correct only when nvim starts at the project root
    '--compile-commands-dir=build/debug',
  },
})

-- nixd config
local flake = '(builtins.getFlake (builtins.getenv "HOME" + "/dotfile"))' -- assumes the flake lives at $HOME/dotfile
vim.lsp.config('nixd', {
  settings = {
    nixd = {
      formatting = { command = { 'nixfmt' } },
      options = vim.fn.has('mac') == 1 and {
        home_manager = { expr = flake .. '.homeConfigurations.mac.options' },
      } or { nixos = { expr = flake .. '.nixosConfigurations.nixos.options' } },
    },
  },
})

-- hledger config
vim.lsp.config("hledger_lsp", {
  cmd = { "hledger-lsp" },
  filetypes = { "hledger" },
  root_markers = { ".git" },
})
vim.lsp.enable("hledger_lsp")

-- enable only servers whose binary is on PATH
local servers = {
  clangd = 'clangd',
  html = 'vscode-html-language-server',
  cssls = 'vscode-css-language-server',
  lua_ls = 'lua-language-server',
  emmet_language_server = 'emmet-language-server',
  rust_analyzer = 'rust-analyzer',
  ruff = 'ruff',
  nixd = 'nixd',
}
local enabled_servers = {}
for name, bin in pairs(servers) do
  if vim.fn.executable(bin) == 1 then
    table.insert(enabled_servers, name)
  end
end
vim.lsp.enable(enabled_servers)

-- lsp keymap define with telescope.builtin
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach-keymaps', { clear = true }),
  desc = 'Set LSP keymaps with telescope pickers',
  callback = function(event)
    local builtin = require('telescope.builtin')
    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('grr', builtin.lsp_references, 'references')
    map('gri', builtin.lsp_implementations, 'implementation')
    map('grd', builtin.lsp_definitions, 'definition')
    map('grt', builtin.lsp_type_definitions, 'type definition')
    map('gO', builtin.lsp_document_symbols, 'document symbols')
    map('gW', builtin.lsp_dynamic_workspace_symbols, 'workspace symbols')
  end,
})
