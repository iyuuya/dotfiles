local mycmp = {
  setup = function(use)
    -- LSP
    use("neovim/nvim-lspconfig")
    use("folke/neodev.nvim")

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
