-- Set leader before loading plugins
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- bootstrap lazy.nvim, LazyVim and user plugins
require("config.lazy")
