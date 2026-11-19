-- INFO: define the PackChanged hook before any vim.pack.add call (the first install fires it)
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('pack-build-hooks', { clear = true }),
  desc = 'Run build steps after install/update: TSUpdate (treesitter), make (telescope-fzf-native)',
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
    -- build the native fzf library (skipped silently when make is missing)
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
