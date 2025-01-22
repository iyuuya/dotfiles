-- local dev = {
--   setup = function(use)
--     use("lambdalisue/readablefold.vim")
--
--     use('mhinz/vim-startify')
--     use('DanilaMihailov/beacon.nvim')
--     use({
--       "SmiteshP/nvim-navic",
--       requries = "neovim/nvim-lspconfig"
--     })
--     use('Yggdroot/indentLine')
--     use('voldikss/vim-floaterm')
--
--     -- Snippet
--     use({
--       "L3MON4D3/LuaSnip",
--       requires = { "rafamadriz/friendly-snippets" },
--       config = function()
--         require("luasnip.loaders.from_vscode").lazy_load()
--
--         vim.cmd([[imap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>']])
--         vim.cmd([[smap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>']])
--       end,
--     })
--
--     use("tpope/vim-abolish")
--
--     use("wakatime/vim-wakatime")
--
--     -- use("jamestthompson3/nvim-remote-containers")
--     use({
--       'esensar/nvim-dev-container',
--       requires = { 'nvim-treesitter/nvim-treesitter' },
--       config = function()
--         require('devcontainer').setup {
--           attach_mounts = {
--             neovim_config = {
--               enabled = true
--             },
--             neovim_data = {
--               enabled = true
--             },
--             neovim_state = {
--               enabled = true
--             }
--           }
--         }
--       end
--     })
--
--
--     use("rcarriga/nvim-notify")
--
--     -- highlight
--     use({
--       "RRethy/vim-illuminate",
--       config = function()
--         require("illuminate").configure({
--           providers = {
--             "lsp",
--             "treesitter",
--             "regex",
--           },
--           delay = 100,
--         })
--       end
--     })
--     use({
--       "norcalli/nvim-colorizer.lua",
--       config = function()
--         require("colorizer").setup()
--       end
--     })
--     use({
--       "t9md/vim-quickhl",
--       config = function()
--         vim.keymap.set("n", "<leader>m", "<Plug>(quickhl-manual-this)", {})
--         vim.keymap.set("x", "<leader>m", "<Plug>(quickhl-manual-this)", {})
--         vim.keymap.set("n", "<leader>M", "<Plug>(quickhl-manual-reset)", {})
--         vim.keymap.set("x", "<leader>M", "<Plug>(quickhl-manual-reset)", {})
--       end
--     })
--     use({
--       "folke/todo-comments.nvim",
--       config = function()
--         require("todo-comments").setup({})
--       end
--     })
--
--     -- scrollbar
--     use({
--       "kevinhwang91/nvim-hlslens",
--       config = function()
--         require("hlslens").setup({
--           build_position_cb = function(plist, _, _, _)
--             require("scrollbar.handlers.search").handler.show(plist.start_pos)
--           end
--         })
--
--         -- TODO: nvim_create_augroup
--         -- TODO: nvim_create_autocmd
--         vim.cmd [[
--         augroup scrollbar_search_hide
--           autocmd!
--           autocmd CmdlineLeave : lua require("scrollbar.handlers.search").handler.hide()
--         augroup END
--       ]]
--       end
--     })
--     use({
--       "petertriho/nvim-scrollbar",
--       requires = { "lewis6991/gitsigns.nvim", "kevinhwang91/nvim-hlslens" },
--       config = function()
--         require("scrollbar").setup()
--       end
--     })
--     use({
--       "lewis6991/gitsigns.nvim",
--       config = function()
--         require("gitsigns").setup()
--         require("scrollbar.handlers.gitsigns").setup()
--       end
--     })
--
--     -- align
--     use({
--       "junegunn/vim-easy-align",
--       config = function()
--         vim.keymap.set("n", "<leader>ga", "<Plug>(EasyAlign)", {})
--         vim.keymap.set("x", "<leader>ga", "<Plug>(EasyAlign)", {})
--       end
--     })
--
--     -- show key map
--     use({
--       "folke/which-key.nvim",
--       config = function()
--         require("which-key").setup({})
--       end
--     })
--
--     -- mkdir
--     use("jghauser/mkdir.nvim")
--
--     -- terminal
--     use({
--       "akinsho/toggleterm.nvim",
--       config = function()
--         require("toggleterm").setup()
--       end
--     })
--
--     -- comment
--     use({
--       "numToStr/Comment.nvim",
--       config = function()
--         require("Comment").setup()
--       end
--     })
--     use("LudoPinelli/comment-box.nvim")
--
--     -- match / pair
--     use({
--       "andymass/vim-matchup",
--       setup = function()
--         vim.g.matchup_matchparen_offscreen = { method = "popup" }
--       end
--     })
--     use({
--       "windwp/nvim-autopairs",
--       config = function()
--         require("nvim-autopairs").setup({})
--       end
--     })
--     use({
--       "windwp/nvim-ts-autotag",
--       config = function()
--         require("nvim-ts-autotag").setup()
--       end
--     })
--
--     -- outline
--     use({
--       "stevearc/aerial.nvim",
--       config = function()
--         require("aerial").setup({
--           on_attach = function(bufnr)
--             vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
--             vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
--             vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>", { buffer = bufnr })
--           end
--         })
--       end
--     })
--   end
-- }
--
-- return dev
--
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require('lualine').setup({})
    end,
  },
  {
    "tpope/vim-dadbod",
  },
  {
    "pbogut/vim-dadbod-ssh"
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    config = function()
      vim.g.db_ui_save_location = '/Users/yuya-ito/work/kufu-ai/iyuuya-private/exam/saved/'
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_preview_options = {
        uml = {
          server = "https://kroki.iyuuya-infra.orb.local/plantuml/",
          imageFormat = "svg",
        }
      }
    end,
    ft = { "markdown" },
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
}
