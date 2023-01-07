--  1 important

--  2 moving around, searching and patterns
vim.opt.wrapscan = true
vim.opt.incsearch = true
vim.opt.smartcase = true

--  3 tags

--  4 displaying text
vim.opt.scrolloff = 5
vim.opt.cmdheight = 2
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

--  5 syntax, highlighting and spelling
vim.opt.background = "dark"
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.cursorcolumn = false
vim.opt.cursorline = true
vim.opt.spell = true
vim.opt.spelllang = "en"

--  6 multiple windows
vim.opt.laststatus = 3

-- vim.opt.statusline =
vim.opt.splitbelow = true
vim.opt.splitright = true

--  7 multiple tab pages
vim.opt.showtabline = 2

--  8 terminal

--  9 using the mouse
vim.opt.mouse = "a"

-- 10 printing

-- 11 messages and info
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.ruler = true

-- 12 selecting text
vim.opt.clipboard = "unnamed"

-- 13 editing text
vim.opt.infercase = true
vim.opt.showmatch = true

-- 14 tabs and indenting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- 15 folding
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"
vim.opt.foldmethod = "syntax"

-- 16 diff mode

-- 17 mapping
vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 750
vim.opt.ttimeoutlen = 0

-- 18 reading and writing files
vim.opt.modeline = true
vim.opt.modelines = 3
vim.opt.fileformat = "unix"

-- 19 the swap file

-- 20 command line editing
vim.opt.wildmode = "list:longest,list"
vim.opt.wildmenu = true
vim.cmdwinheight = 5

-- 21 executing external commands

-- 22 running make and jumping to errors (quickfix)
if vim.fn.executable('rg') then
  vim.opt.grepprg = "rg --vimgrep --hidden > /dev/null"
  vim.opt.grepformat = "%f:%l:%c:%m"
end

-- 23 language specific

-- 24 multi-byte characters

-- 25 various

----

vim.g.mapleader = ","
vim.opt.guifont = "SauceCodePro Nerd Font:h11"

vim.filetype.add({
  filename = {
    ["Schemafile"] = "ruby",
  },
})

local ft_go_augroup = vim.api.nvim_create_augroup("FileTypeGo", {})
vim.api.nvim_create_autocmd("FileType", {
  group = ft_go_augroup,
  pattern = "go",
  callback = function()
    vim.bo.expandtab   = false
    vim.bo.shiftwidth  = 4
    vim.bo.softtabstop = 4
    vim.bo.tabstop     = 4
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = ft_go_augroup,
  pattern = "make",
  callback = function()
    vim.bo.expandtab   = false
    vim.bo.shiftwidth  = 4
    vim.bo.softtabstop = 4
    vim.bo.tabstop     = 4
  end
})
