-- vim-fugitive設定
vim.opt.diffopt = "vertical"

-- キーマッピング設定
vim.api.nvim_set_keymap("n", "<Leader>vs", ":Git<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>vr', ':Gread<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>vw', ':Gwrite<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>vc", ":Gcommit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>vd", ":Gdiff<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>vu", ":diffupdate<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>2", ":diffget //2 | diffupdate<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>3", ":diffget //3 | diffupdate<CR>", { noremap = true, silent = true })

return {
  {
    "tpope/vim-fugitive",
    lazy = false, -- このオプションは、Lazy.nvimの設定に合わせて変更可能です
  },
}
