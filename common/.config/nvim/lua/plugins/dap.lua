-- [[ DAP ]]
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

vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: continue / start' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: step over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: step into' })
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: toggle [b]reakpoint' })

-- DAP UI
vim.pack.add({
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/rcarriga/nvim-dap-ui',
})

local dapui = require('dapui')
dapui.setup()

-- open/close the UI with the debug session
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

vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: toggle ui' })
vim.keymap.set({ 'n', 'v' }, '<leader>de', dapui.eval, { desc = 'Debug: eval expression' })
