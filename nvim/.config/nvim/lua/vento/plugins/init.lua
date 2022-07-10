local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print("Installing packer.nvim")
  PACKER_BOOSTRAP = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.api.nvim_command("packadd packer.nvim")
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({})

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  -- FuzzyFinder
  use("lotabout/skim")
  use("lotabout/skim.vim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        sync_install = false,
        highlight = {
          enable = true,
          additonal_vim_regex_highlighting = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "gdm",
          },
        },
        indent = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@funciton.outer",
              ["if"] = "@funciton.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["ap"] = "@parameter.outer",
              ["ip"] = "@parameter.inner",
            },
          },
        },
      })

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  })
  use("nvim-treesitter/nvim-treesitter-textobjects")

  -- Colorscheme
  -- use({
  --   "ellisonleao/gruvbox.nvim",
  --   requires = { "rktjmp/lush.nvim" },
  --   config = function()
  --     vim.opt.background = "dark"
  --     vim.cmd([[
  --       colorscheme gruvbox
  --       hi Normal ctermbg=NONE guibg=NONE
  --     ]])
  --   end,
  -- })
  use({
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd([[
        colorscheme nightfox
      ]])
    end
  })
  use('mhinz/vim-startify')
  use('DanilaMihailov/beacon.nvim')
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup{}
    end,
  })
  use('Yggdroot/indentLine')
  use({'windwp/nvim-autopairs',
    config =function()
      require('nvim-autopairs').setup{}
    end,
  })
  use('voldikss/vim-floaterm')

  use({
    "crispgm/nvim-go",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
    }
  })

  -- LSP
  use("neovim/nvim-lspconfig")
  use("folke/lua-dev.nvim")

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

  -- cmp
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
      cmp.setup.cmdline("/", { sources = { name = "buffer" } })
      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })

      local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require("lspconfig")
      local luadev = require("lua-dev")

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        local opts = { noremap = true, silent = true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
        buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
        buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      end

      lspconfig.sumneko_lua.setup(
        luadev.setup({
          runtime_path = true,
          lspconfig = {
            on_attach = on_attach,
          },
          capabilities = capabilities,
        })
      )
      lspconfig.clangd.setup({
        on_attach = on_attach,
        debounce_text_changes = 150,
        capabilities = capabilities,
      })
      lspconfig.cmake.setup({
        on_attach = on_attach,
        debounce_text_changes = 150,
        capabilities = capabilities,
      })
      lspconfig.tsserver.setup({
        on_attach = on_attach,
        debounce_text_changes = 150,
        capabilities = capabilities,
      })
      lspconfig.rls.setup({
        on_attach = on_attach,
        debounce_text_changes = 150,
        capabilities = capabilities,
      })
      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        debounce_text_changes = 150,
        capabilities = capabilities,
      })

      require("go").setup({})

      --lspconfig.golangci_lint_ls.setup({
      --  on_attach = on_attach,
      --  debounce_text_changes = 150,
      --  capabilities = capabilities,
      --})
      lspconfig.gopls.setup({
        on_attach = on_attach,
        debounce_text_changes = 150,
        capabilities = capabilities,
      })

      lspconfig.solargraph.setup({
        on_attach = on_attach,
        debounce_text_changes = 150,
        capabilities = capabilities,
      })

      lspconfig.dockerls.setup({
        on_attach = on_attach,
        debounce_text_changes = 150,
        capabilities = capabilities,
      })

      lspconfig.yamlls.setup({
        on_attach = on_attach,
        debounce_text_changes = 150,
        capabilities = capabilities,
      })

      -- Use a loop to conveniently call "setup" on multiple servers and
      -- map buffer local keybindings when the language server attaches
      -- local servers = { "rust_analyzer", "tsserver" }
      -- for _, lsp in ipairs(servers) do
      --   lspconfig[lsp].setup {
      --     on_attach = on_attach,
      --     flags = {
      --       debounce_text_changes = 150,
      --     }
      --   }
      -- end
    end
  })

  use("sgur/vim-editorconfig")

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
      require('nvim-tree').setup{}
    end
  })

  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_start = true
    end,
    ft = { "markdown" }
  })

  use("tpope/vim-abolish")

  use("wakatime/vim-wakatime")

  use("tpope/vim-rails")

  if PACKER_BOOSTRAP then
    require("packer").sync()
  end
end)
