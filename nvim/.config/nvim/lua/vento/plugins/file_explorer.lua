local file_explorer = {
  setup = function(use)
    use({
      "kevinhwang91/rnvimr",
      config = function()
        vim.g.rnvimr_enable_ex = 1
        vim.g.rnvimr_enable_picker = 1
        vim.g.rnvimr_draw_border = 1
        vim.g.rnvimr_hide_gitignore = 1
        vim.cmd([[
        let g:rnvimr_action = {
        \ '<C-t>': 'NvimEdit tabedit',
        \ '<C-x>': 'NvimEdit split',
        \ '<C-v>': 'NvimEdit vsplit',
        \ }
        ]])
      end
    })
    use({
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('nvim-tree').setup {}
      end
    })
  end
}

return file_explorer
