-- [[ Im-select ]]
--   mac : macism
--   linux: fcitx5-remote
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
