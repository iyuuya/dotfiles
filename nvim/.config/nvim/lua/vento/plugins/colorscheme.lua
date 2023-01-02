local colorscheme = {
  setup = function(use)
    -- Colorscheme
    use({
      "ellisonleao/gruvbox.nvim",
      requires = { "rktjmp/lush.nvim" },
      config = function()
        vim.opt.background = "dark"
        vim.cmd([[
        colorscheme gruvbox
        hi Normal ctermbg=NONE guibg=NONE
        ]])
      end,
    })
    use({
      "EdenEast/nightfox.nvim",
      -- config = function()
      --   vim.cmd([[
      --     colorscheme nightfox
      --   ]])
      -- end
    })
    use({
      "chriskempson/vim-tomorrow-theme",
      -- config = function()
      --   vim.cmd([[colorscheme Tomorrow-Night-Bright]])
      -- end
    })
    use({
      "xiyaowong/nvim-transparent",
      config = function()
        require('transparent').setup({
          enable = true
        })
      end
    })
  end
}

return colorscheme
