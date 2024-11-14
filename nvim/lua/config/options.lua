-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- エンコーディング設定
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"

-- モード表示
vim.opt.showmode = true

-- スクロールオフセット
vim.opt.scrolloff = 10

-- クリップボード設定（unnamedに追加）
-- vim.opt.clipboard:append("unnamed")

-- 自動補完オプションからプレビューを削除
vim.opt.completeopt:remove("preview")

-- バックアップ設定
-- vim.opt.backup = true
-- vim.opt.backupdir = os.getenv("HOME") .. "/vimbackup"

-- 折りたたみ方法とレベルの設定
vim.opt.foldmethod = "syntax"
vim.opt.foldlevel = 20

-- インクリメントとデクリメントを無効化
vim.api.nvim_set_keymap("n", "<C-A>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-X>", "<NOP>", { noremap = true, silent = true })

vim.o.splitbelow = false
vim.o.relativenumber = false
