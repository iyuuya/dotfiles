return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      vim.opt.background = "dark"
      vim.cmd([[
      colorscheme gruvbox
      hi Normal ctermbg=NONE guibg=NONE
      ]])
    end,
  },
}
