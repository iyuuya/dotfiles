local dev= {
  setup = function(use)
    use("lambdalisue/readablefold.vim")

    use('mhinz/vim-startify')
    use('DanilaMihailov/beacon.nvim')
    use({
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('lualine').setup {}
      end,
    })
    use('Yggdroot/indentLine')
    use({ 'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup {}
      end,
    })
    use('voldikss/vim-floaterm')

    -- Snippet
    use({
      "L3MON4D3/LuaSnip",
      requires = { "rafamadriz/friendly-snippets" },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        vim.cmd([[imap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>']])
        vim.cmd([[smap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>']])
      end,
    })

    use("tpope/vim-abolish")

    use("wakatime/vim-wakatime")

    -- use("jamestthompson3/nvim-remote-containers")
    use({
      'esensar/nvim-dev-container',
      requires = { 'nvim-treesitter/nvim-treesitter' },
      config = function()
        require('devcontainer').setup {
          attach_mounts = {
            neovim_config = {
              enabled = true
            },
            neovim_data = {
              enabled = true
            },
            neovim_state = {
              enabled = true
            }
          }
        }
      end
    })
  end
}

return dev
