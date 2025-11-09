vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 0
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.scrolloff = 5

vim.opt.exrc = true
vim.opt.secure = true

require("config.lazy")
require("lsp")

-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme kanagawa]])
-- vim.cmd([[colorscheme everforest]])
