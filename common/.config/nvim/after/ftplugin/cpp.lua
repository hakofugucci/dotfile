-- C++ ファイル用の設定
vim.opt_local.makeprg = 'cmake --build --preset debug'
vim.opt_local.errorformat = '%f:%l:%c: %t%*[^:]: %m,%f:%l: %t%*[^:]: %m'
