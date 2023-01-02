local filetype = {
  setup = function(use)
    use("kchmck/vim-coffee-script")
    use("omnisyle/nvim-hidesig")
    use("pocke/rbs.vim")
    use("tpope/vim-rails")
    use({
      "crispgm/nvim-go",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
      }
    })
    use("tokorom/vim-review")
    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      setup = function()
        vim.g.mkdp_filetypes = { "markdown" }
        vim.g.mkdp_auto_start = false
      end,
      ft = { "markdown" }
    })
    use("sgur/vim-editorconfig")
  end
}

return filetype
