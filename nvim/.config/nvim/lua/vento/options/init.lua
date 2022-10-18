vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.foldlevelstart = 99
vim.opt.termguicolors = true
vim.opt.showtabline = 2
vim.opt.clipboard = "unnamed"
vim.opt.laststatus = 3

vim.opt.guifont = "SauceCodePro Nerd Font:h11"

vim.cmd[[autocmd BufRead,BufNewFile Schemafile set filetype=ruby]]
