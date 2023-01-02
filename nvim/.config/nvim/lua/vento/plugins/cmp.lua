local mycmp = {
  setup = function(use)
    -- LSP
    use("neovim/nvim-lspconfig")
    use("folke/neodev.nvim")
    use({
      "kkharji/lspsaga.nvim",
      config = function()
        require("lspsaga").setup({})
      end
    })
    use({
      "folke/lsp-colors.nvim",
      config = function()
        require("lsp-colors").setup({})
      end
    })
    use({
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        require("trouble").setup({})
      end
    })
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup({})
      end
    })

    use({
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup({
          -- TODO: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
          sources = {
            null_ls.builtins.formatting.stylua,

            null_ls.builtins.code_actions.eslint,
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.formatting.eslint,

            null_ls.builtins.formatting.rubocop,
            null_ls.builtins.diagnostics.rubocop,

            null_ls.builtins.code_actions.gitsigns,

            null_ls.builtins.formatting.rustfmt,
          },
          on_attach = function(client, bufnr)
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = bufnr,
                  filter = function(client)
                    return client.name == "null-ls"
                  end
                })
              end
            })
          end
        })
        -- vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", {})
      end
    })

    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("hrsh7th/cmp-nvim-lsp-document-symbol")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-emoji")
    use("hrsh7th/cmp-calc")
    use("f3fora/cmp-spell")
    use({
      "yutkat/cmp-mocword",
      requires = "nvim-lua/plenary.nvim",
    })
    use("uga-rosa/cmp-dictionary")
    use({
      "saadparwaiz1/cmp_luasnip",
      requires = "L3MON4D3/LuaSnip",
    })
    use("ray-x/cmp-treesitter")
    use("onsails/lspkind.nvim")

    use({
      "hrsh7th/nvim-cmp",
      config = function()
        local has_words_before = function()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local navic = require("nvim-navic")

        local cmp_sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "treesitter" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "cmdline" },
          { name = "calc" },
          { name = "dictionary", keyword_length = 2 },
          {
            name = "spell",
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return true
              end
            }
          },
          { name = "emoji" },
          { name = "mocword" },
        }

        cmp.setup({
          mapping = {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-l>"] = cmp.mapping.complete({}),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
          sources = cmp_sources,
          formatting = {
            format = lspkind.cmp_format({
              mode = "symbol",
              maxwidth = 50,
              elipsis_char = "...",
            }),
          },
        })

        cmp.setup.cmdline({ "/", "?" }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "nvim_lsp_document_symbol" }
          }, {
            { name = "buffer" }
          })
        })

        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
            { name = "cmdline" },
          }),
        })

        require("cmp_dictionary").setup({
          dic = {
            -- ["*"] = { "/usr/share/dict/words" },
            -- ["lua"] = {},
            -- filename = {},
            -- filepath = {},
            -- spellang = {},
          },
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")
        local luadev = require("neodev").setup({})

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
          buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

          if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
          end
        end

        lspconfig.sumneko_lua.setup({
          settings = {
            Lua = {
              completaion = {
                callSnippet = "Replace"
              }
            }
          },
          runtime_path = true,
          on_attach = on_attach,
          capabilities = capabilities,
        })
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
        -- lspconfig.rls.setup({
        --   on_attach = on_attach,
        --   debounce_text_changes = 150,
        --   capabilities = capabilities,
        -- })
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

        lspconfig.pylsp.setup({
          on_attach = on_attach,
          debounce_text_changes = 150,
          capabilities = capabilities,
        })

        lspconfig.graphql.setup({
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
  end
}

return mycmp
