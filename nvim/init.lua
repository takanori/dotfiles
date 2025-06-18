-- Set leader before loading plugins
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Provide `vim.version.ge` on older Neovim releases
if vim.version and not vim.version.ge and vim.version.cmp then
  ---Compare if version {v1} is greater or equal to {v2}
  ---@param v1 any -- table | number[] | string
  ---@param v2 any -- table | number[] | string
  ---@return boolean
  vim.version.ge = function(v1, v2)
    return vim.version.cmp(v1, v2) >= 0
  end
end

-- bootstrap lazy.nvim, LazyVim and user plugins
require("config.lazy")
