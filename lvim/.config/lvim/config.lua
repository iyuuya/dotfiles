vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr"

-- general
lvim.log.level = "warn"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
lvim.transparent_window = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.builtin.telescope.defaults.layout_config.width = 0.9
lvim.builtin.telescope.defaults.layout_config.height = 0.8

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.treesitter.highlight.enable = true

lvim.builtin.nvimtree.setup.view.width = 48

-- ---@usage disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

lvim.lsp.on_attach_callback = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

lvim.format_on_save = true

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { command = "flake8", filetypes = { "python" } },
  -- {
  --   -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "shellcheck",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--severity", "warning" },
  -- },
  -- {
  --   command = "codespell",
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "javascript", "python" },
  -- },
  -- {
  --   command = "eslint",
  --   filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  -- }
}
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
  { name = "rustfmt" },
  {
    name = "rubocop",
    args = { "-A" },
  },
  { name = "beautysh" },
  {
    name = "shfmt",
    filetypes = { "bash", "zsh", "shell" },
  },
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })
local clangd_flags = {
  "--background-index",
  "--fallback-style=Google",
  "--all-scopes-completion",
  "--clang-tidy",
  "--log=error",
  "--suggest-missing-includes",
  "--cross-file-rename",
  "--completion-style=detailed",
  "--pch-storage=memory",     -- could also be disk
  "--folding-ranges",
  "--enable-config",          -- clangd 11+ supports reading from .clangd configuration file
  "--offset-encoding=utf-16", --temporary fix for null-ls
  -- "--limit-references=1000",
  -- "--limit-resutls=1000",
  -- "--malloc-trim",
  -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
  -- "--header-insertion=never",
  -- "--query-driver=<list-of-white-listed-complers>"
}

local provider = "clangd"

local custom_on_attach = function(client, bufnr)
  require("lvim.lsp").common_on_attach(client, bufnr)

  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<leader>lh", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
  vim.keymap.set("x", "<leader>lA", "<cmd>ClangdAST<cr>", opts)
  vim.keymap.set("n", "<leader>lH", "<cmd>ClangdTypeHierarchy<cr>", opts)
  vim.keymap.set("n", "<leader>lt", "<cmd>ClangdSymbolInfo<cr>", opts)
  vim.keymap.set("n", "<leader>lm", "<cmd>ClangdMemoryUsage<cr>", opts)

  require("clangd_extensions.inlay_hints").setup_autocmd()
  require("clangd_extensions.inlay_hints").set_inlay_hints()
end

local status_ok, project_config = pcall(require, "rhel.clangd_wrl")
if status_ok then
  clangd_flags = vim.tbl_deep_extend("keep", project_config, clangd_flags)
end

local custom_on_init = function(client, bufnr)
  require("lvim.lsp").common_on_init(client, bufnr)
  require("clangd_extensions.config").setup {}
  require("clangd_extensions.ast").init()
  vim.cmd [[
  command ClangdToggleInlayHints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
  command -range ClangdAST lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
  command ClangdTypeHierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
  command ClangdSymbolInfo lua require('clangd_extensions.symbol_info').show_symbol_info()
  command -nargs=? -complete=customlist,s:memuse_compl ClangdMemoryUsage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
  ]]
end

local opts = {
  cmd = { provider, unpack(clangd_flags) },
  on_attach = custom_on_attach,
  on_init = custom_on_init,
}

require("lvim.lsp.manager").setup("clangd", opts)

-- install codelldb with :MasonInstall codelldb
-- configure nvim-dap (codelldb)
lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
      command = "codelldb",
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return require("xmake").config.target_exec_path
        -- local path
        -- vim.ui.input({ prompt = "Path to executable: ", default = vim.loop.cwd() .. "/build/" }, function(input)
        --   path = input
        -- end)
        -- vim.cmd [[redraw]]
        -- return path
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
  dap.configurations.c = dap.configurations.cpp
end

-- Additional Plugins
lvim.plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      -- require("tokyonight").setup({
      --   transparent = true, -- Enable this to disable setting the background color
      -- })
      -- lvim.colorscheme = "tokyonight-night"
      -- vim.cmd [[colorscheme tokyonight-night]]
    end,
  },
  {
    "deparr/tairiki.nvim",
    --   require('tairiki').load()
    -- config = function()
    -- end,
  },
  {
    "rebelot/kanagawa.nvim",
    -- config = function()
    --   require('kanagawa').setup({
    --     background = {
    --       dark = "dragon"
    --     },
    --     overrides = function(colors)
    --       local theme = colors.theme
    --       return {
    --         -- Assign a static color to strings
    --         String = { fg = colors.palette.carpYellow, italic = true },
    --         -- theme colors will update dynamically when you change theme!
    --         SomePluginHl = { fg = colors.theme.syn.type, bold = true },

    --         -- NormalFloat = { bg = "none" },
    --         -- FloatBorder = { bg = "none" },
    --         -- FloatTitle = { bg = "none" },

    --         -- Save an hlgroup with dark background and dimmed foreground
    --         -- so that you can use it where your still want darker windows.
    --         -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
    --         NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

    --         -- Popular plugins that open floats will link to NormalFloat by default;
    --         -- set their background accordingly if you wish to keep them dark and borderless
    --         LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
    --         MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

    --         TelescopeTitle = { fg = theme.ui.special, bold = true },
    --         TelescopePromptNormal = { bg = theme.ui.bg_p1 },
    --         TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
    --         TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
    --         TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
    --         TelescopePreviewNormal = { bg = theme.ui.bg_dim },
    --         TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
    --       }
    --     end,
    --   })
    -- end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      vim.opt.background = "dark"
      vim.cmd [[colorscheme gruvbox]]
      lvim.colorscheme = "gruvbox"
    end,
  },
  {
    "neanias/everforest-nvim",
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup()
    end,
  },
  {
    "nyoom-engineering/oxocarbon.nvim"
  },
  {
    "savq/melange-nvim"
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "azabiong/vim-highlighter"
  },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "junegunn/fzf"
  },
  {
    "junegunn/fzf.vim"
  },
  {
    "google/vim-jsonnet"
  },
  {
    "gpanders/editorconfig.nvim"
  },
  {
    "kchmck/vim-coffee-script"
  },
  {
    "wakatime/vim-wakatime"
  },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   config = function()
  --     require("chatgpt").setup({
  --       api_host_cmd = 'echo -n http://localhost:1337',
  --       loading_text = "loading",
  --       question_sign = "", -- you can use emoji if you want e.g. 🙂
  --       answer_sign = "ﮧ", -- 🤖
  --       max_line_length = 120,
  --       yank_register = "+",
  --       chat_layout = {
  --         relative = "editor",
  --         position = "50%",
  --         size = {
  --           height = "80%",
  --           width = "80%",
  --         },
  --       },
  --       settings_window = {
  --         border = {
  --           style = "rounded",
  --           text = {
  --             top = " Settings ",
  --           },
  --         },
  --       },
  --       chat_window = {
  --         filetype = "chatgpt",
  --         border = {
  --           highlight = "FloatBorder",
  --           style = "rounded",
  --           text = {
  --             top = " ChatGPT ",
  --           },
  --         },
  --       },
  --       chat_input = {
  --         prompt = "  ",
  --         border = {
  --           highlight = "FloatBorder",
  --           style = "rounded",
  --           text = {
  --             top_align = "center",
  --             top = " Prompt ",
  --           },
  --         },
  --       },
  --       openai_params = {
  --         model = "gpt-3.5-turbo",
  --         frequency_penalty = 0,
  --         presence_penalty = 0,
  --         max_tokens = 300,
  --         temperature = 0,
  --         top_p = 1,
  --         n = 1,
  --       },
  --       openai_edit_params = {
  --         model = "code-davinci-edit-001",
  --         temperature = 0,
  --         top_p = 1,
  --         n = 1,
  --       },
  --       keymaps = {
  --         close = { "<C-c>" },
  --         submit = "<C-g>",
  --         yank_last = "<C-y>",
  --         yank_last_code = "<C-k>",
  --         scroll_up = "<C-u>",
  --         scroll_down = "<C-d>",
  --         toggle_settings = "<C-o>",
  --         new_session = "<C-n>",
  --         cycle_windows = "<Tab>",
  --         -- in the Sessions pane
  --         select_session = "<Space>",
  --         rename_session = "r",
  --         delete_session = "d",
  --       },
  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "folke/trouble.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- },
  {
    "huynle/ogpt.nvim",
    event = "VeryLazy",
    opts = {
      default_provider = "ollama",
      providers = {
        ollama = {
          api_host = os.getenv("OLLAMA_API_HOST") or "http://localhost:11434",
          api_key = os.getenv("OLLAMA_API_KEY") or "",
        }
      }
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {
    "ziontee113/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = { "<C-p>" },
    config = function()
      local ollama = require("ollama")
      vim.keymap.set("n", "<C-p>", function() ollama.show() end, {})
    end,
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen" -- or "topline" or "screen"
    end,
    opts = {
      exit_when_last = false,
      animate = {
        enabled = false,
      },
      wo = {
        winbar = true,
        winfixwidth = true,
        winfixheight = false,
        winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
        spell = false,
        signcolumn = "no",
      },
      keys = {
        -- -- close window
        ["q"] = function(win)
          win:close()
        end,
        -- close sidebar
        ["Q"] = function(win)
          win.view.edgebar:close()
        end,
        -- increase width
        ["<S-Right>"] = function(win)
          win:resize("width", 3)
        end,
        -- decrease width
        ["<S-Left>"] = function(win)
          win:resize("width", -3)
        end,
        -- increase height
        ["<S-Up>"] = function(win)
          win:resize("height", 3)
        end,
        -- decrease height
        ["<S-Down>"] = function(win)
          win:resize("height", -3)
        end,
      },
      right = {
        {
          title = "OGPT Popup",
          ft = "ogpt-popup",
          size = { width = 0.2 },
          wo = {
            wrap = true,
          },
        },
        {
          title = "OGPT Parameters",
          ft = "ogpt-parameters-window",
          size = { height = 6 },
          wo = {
            wrap = true,
          },
        },
        {
          title = "OGPT Template",
          ft = "ogpt-template",
          size = { height = 6 },
        },
        {
          title = "OGPT Sessions",
          ft = "ogpt-sessions",
          size = { height = 6 },
          wo = {
            wrap = true,
          },
        },
        {
          title = "OGPT System Input",
          ft = "ogpt-system-window",
          size = { height = 6 },
        },
        {
          title = "OGPT",
          ft = "ogpt-window",
          size = { height = 0.5 },
          wo = {
            wrap = true,
          },
        },
        {
          title = "OGPT {{{selection}}}",
          ft = "ogpt-selection",
          size = { width = 80, height = 4 },
          wo = {
            wrap = true,
          },
        },
        {
          title = "OGPt {{{instruction}}}",
          ft = "ogpt-instruction",
          size = { width = 80, height = 4 },
          wo = {
            wrap = true,
          },
        },
        {
          title = "OGPT Chat",
          ft = "ogpt-input",
          size = { width = 80, height = 4 },
          wo = {
            wrap = true,
          },
        },
      },
    },
  },
  {
    'kraftwerk28/gtranslate.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require("gtranslate").setup {
        default_to_language = "Japanese"
      }
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
      vim.g.db_ui_save_location = '/Users/yuya-ito/work/tokubai/iyuuya-private/exam/saved/'
    end
  },
  -- denops + graphql
  {
    'skanehira/denops-graphql.vim',
    dependencies = {
      'vim-denops/denops.vim',
    },
  },
  {
    "vim-crystal/vim-crystal"
  },
  {
    "rbtnn/vim-puyo",
    dependencies = {
      "rbtnn/vim-game_engine",
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_preview_options = {
        uml = {
          server = "https://core.iyuuya-infra.orb.local/plantuml/",
          imageFormat = "svg",
        }
      }
    end,
    ft = { "markdown" },
  },
  {
    "p00f/clangd_extensions.nvim",
  },
  {
    "mfussenegger/nvim-dap"
  },
  {
    "ray-x/go.nvim"
  },
  {
    "Mythos-404/xmake.nvim",
    lazy = true,
    event = "BufReadPost xmake.lua",
    config = true,
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
        require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
      end, 100)
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    opts = {
      debug = true,
    },
  },

  -- Git
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { enabled = false }
    end,
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("octo").setup()
    end,
  },
  {
    "tpope/vim-rails",
  },
  {
    "mogulla3/rspec.nvim",
    config = function()
      require("rspec").setup()
    end,
  },
  {
    "ttbug/tig.nvim",
    config = function()
      require("tig").setup()
    end,
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})

-- textDocument/diagnostic support until 0.10.0 is released
local _timers = {}
local function setup_diagnostics(client, buffer)
  if require("vim.lsp.diagnostic")._enable then
    return
  end

  local diagnostic_handler = function()
    local params = vim.lsp.util.make_text_document_params(buffer)
    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
      if err then
        local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
        vim.lsp.log.error(err_msg)
      end
      local diagnostic_items = {}
      if result then
        diagnostic_items = result.items
      end
      vim.lsp.diagnostic.on_publish_diagnostics(
        nil,
        vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
        { client_id = client.id }
      )
    end)
  end

  diagnostic_handler() -- to request diagnostics on buffer when first attaching

  vim.api.nvim_buf_attach(buffer, false, {
    on_lines = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
      _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
    end,
    on_detach = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
    end,
  })
end

require("lspconfig").ruby_lsp.setup({
  on_attach = function(client, buffer)
    setup_diagnostics(client, buffer)
  end,
})
