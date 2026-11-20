-- [[ Git ]]
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
    end, 'Git hunk: next')

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end, 'Git hunk: previous')

    map('n', '<leader>hs', gitsigns.stage_hunk, 'Git hunk: stage')
    map('n', '<leader>hr', gitsigns.reset_hunk, 'Git hunk: reset')
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Git hunk: stage')
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Git hunk: reset')
    map('n', '<leader>hp', gitsigns.preview_hunk, 'Git hunk: preview')
    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end, 'Git hunk: blame line')
    map('n', '<leader>hd', gitsigns.diffthis, 'Git hunk: diff against index')
    map('n', '<leader>hS', gitsigns.stage_buffer, 'Git hunk: stage buffer')
    map('n', '<leader>hR', gitsigns.reset_buffer, 'Git hunk: reset buffer')
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, 'Toggle: git blame line')
    map('n', '<leader>hq', function()
      vim.cmd('diffoff!')
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
        if name:match('^gitsigns://') then
          vim.api.nvim_win_close(win, true)
        end
      end
    end, 'Git hunk: close diff')
    map('n', '<leader>hq', gitsigns.setqflist)
  end,
})

vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/dlyongemallo/diffview-plus.nvim', -- optional
  'https://github.com/NeogitOrg/neogit',
})

local neogit = require('neogit')
neogit.setup({
  integrations = {
    telescope = true,
    diffview = true,
  },
  commit_editor = {
    kind = 'tab',
    show_staged_diff = true,
    staged_diff_split_kind = 'split',
  },
  graph_style = 'unicode',
  mappings = {
    commit_editor = {
      ["q"] = "Close",
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
      ["<c-p>"] = "PrevMessage",
      ["<c-n>"] = "NextMessage",
      ["<c-r>"] = "ResetMessage",
    },
    commit_editor_I = {
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    rebase_editor = {
      ["p"] = "Pick",
      ["r"] = "Reword",
      ["e"] = "Edit",
      ["s"] = "Squash",
      ["f"] = "Fixup",
      ["x"] = "Execute",
      ["d"] = "Drop",
      ["b"] = "Break",
      ["q"] = "Close",
      ["<cr>"] = "OpenCommit",
      ["gk"] = "MoveUp",
      ["gj"] = "MoveDown",
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
      ["[c"] = "OpenOrScrollUp",
      ["]c"] = "OpenOrScrollDown",
    },
    rebase_editor_I = {
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    finder = {
      ["<cr>"] = "Select",
      ["<c-c>"] = "Close",
      ["<esc>"] = "Close",
      ["<c-n>"] = "Next",
      ["<c-p>"] = "Previous",
      ["<down>"] = "Next",
      ["<up>"] = "Previous",
      ["<tab>"] = "InsertCompletion",
      ["<c-y>"] = "CopySelection",
      ["<space>"] = "MultiselectToggleNext",
      ["<s-space>"] = "MultiselectTogglePrevious",
      ["<c-j>"] = "NOP",
      ["<ScrollWheelDown>"] = "ScrollWheelDown",
      ["<ScrollWheelUp>"] = "ScrollWheelUp",
      ["<ScrollWheelLeft>"] = "NOP",
      ["<ScrollWheelRight>"] = "NOP",
      ["<LeftMouse>"] = "MouseClick",
      ["<2-LeftMouse>"] = "NOP",
    },
    -- Setting any of these to `false` will disable the mapping.
    popup = {
      ["?"] = "HelpPopup",
      ["A"] = "CherryPickPopup",
      ["d"] = "DiffPopup",
      ["M"] = "RemotePopup",
      ["P"] = "PushPopup",
      ["X"] = "ResetPopup",
      ["Z"] = "StashPopup",
      ["i"] = "IgnorePopup",
      ["t"] = "TagPopup",
      ["b"] = "BranchPopup",
      ["B"] = "BisectPopup",
      ["w"] = "WorktreePopup",
      ["c"] = "CommitPopup",
      ["f"] = "FetchPopup",
      ["l"] = "LogPopup",
      ["m"] = "MergePopup",
      ["p"] = "PullPopup",
      ["r"] = "RebasePopup",
      ["v"] = "RevertPopup",
    },
    status = {
      ["j"] = "MoveDown",
      ["k"] = "MoveUp",
      ["o"] = "OpenTree",
      ["q"] = "Close",
      ["I"] = "InitRepo",
      ["1"] = "Depth1",
      ["2"] = "Depth2",
      ["3"] = "Depth3",
      ["4"] = "Depth4",
      ["Q"] = "Command",
      ["<tab>"] = "Toggle",
      ["za"] = "Toggle",
      ["zo"] = "OpenFold",
      ["x"] = "Discard",
      ["s"] = "Stage",
      ["S"] = "StageUnstaged",
      ["<c-s>"] = "StageAll",
      ["u"] = "Unstage",
      ["K"] = "Untrack",
      ["U"] = "UnstageStaged",
      ["y"] = "ShowRefs",
      ["$"] = "CommandHistory",
      ["Y"] = "YankSelected",
      ["gp"] = "GoToParentRepo",
      ["<c-r>"] = "RefreshBuffer",
      ["<cr>"] = "GoToFile",
      ["<s-cr>"] = "PeekFile",
      ["<c-v>"] = "VSplitOpen",
      ["<c-x>"] = "SplitOpen",
      ["<c-t>"] = "TabOpen",
      ["{"] = "GoToPreviousHunkHeader",
      ["}"] = "GoToNextHunkHeader",
      ["[c"] = "OpenOrScrollUp",
      ["]c"] = "OpenOrScrollDown",
      ["<c-k>"] = "PeekUp",
      ["<c-j>"] = "PeekDown",
      ["<c-n>"] = "NextSection",
      ["<c-p>"] = "PreviousSection",
    },
  },
})

vim.keymap.set('n', '<leader>gg', function()
  neogit.open()
end, { desc = 'Git: Neogit' })
vim.keymap.set('n', '<leader>gc', function()
  neogit.open({ 'commit' })
end, { desc = 'Git: Neogit commit' })
vim.keymap.set('n', '<leader>gv', function()
  neogit.open({ kind = 'vsplit' })
end, { desc = 'Git: Neogit on vertical' })
vim.keymap.set('n', '<leader>gx', function()
  neogit.open({ kind = 'split' })
end, { desc = 'Git: Neogit on horizontal' })
-- vim.keymap.set('n', '<leader>g~', function()
--   neogit.open({ cwd = '~' })
-- end, { desc = 'Git: Neogit with different project' })


vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = 'Git: diffview open' })
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', { desc = 'Git: file history' })
vim.keymap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory<cr>', { desc = 'Git: repo history' })
vim.keymap.set('n', '<leader>gq', '<cmd>DiffviewClose<cr>', { desc = 'Git: diffview close' })
