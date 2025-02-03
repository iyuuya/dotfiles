-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim

lvim.format_on_save = true
lvim.transparent_window = true
lvim.colorscheme = "gruvbox"

vim.filetype.add({
  extension = {
    es6 = "javascript",
  }
})

lvim.plugins = {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- go
          "golangci-lint",
          "gopls",
          "gofumpt",
          "golines",
          "gomodifytags",
          "gotests",
          "goimports",
          "impl",
          --
          "shellcheck",
          "staticcheck",
          "json-to-struct",
          "editorconfig-checker",
          --
          "actionlint",
          "autotools-language-server",
          "bash-language-server",
          "clangd",
          "css-lsp",
          "delve",
          "dockerfile-language-server",
          "eslint-lsp",
          "html-lsp",
          "impl",
          "jq",
          "json-lsp",
          "lemminx",
          "lua-language-server",
          "prettier",
          "rubocop",
          "ruby-lsp",
          "solargraph",
          "stylua",
          "tailwindcss-language-server",
          "typescript-language-server",
          "yaml-language-server",
          "yamllint",
        },
        integrations = {
          ['mason-lspconfig'] = true,
          ['mason-null-ls'] = true,
          ['mason-nvim-dap'] = true,
        }
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- suggestion = {enabled = false},
        -- panel = {enabled = false},
        copilot_node_command = 'node'
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    build = "make tiktoken",        -- Only on MacOS or Linux
    opts = {
      debug = true,                 -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
    config = function()
      vim.defer_fn(function()
        require("copilot_cmp").setup()
        require("CopilotChat").setup({
          show_help = "yes",
          prompts = {
            Explain = {
              prompt = "/COPILOT_EXPLAIN コードを日本語で説明してください",
              mapping = '<leader>Ce',
              description = "コードの説明をお願いする",
            },
            Review = {
              prompt = '/COPILOT_REVIEW コードを日本語でレビューしてください。',
              mapping = '<leader>Cr',
              description = "コードのレビューをお願いする",
            },
            Fix = {
              prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
              mapping = '<leader>Cf',
              description = "コードの修正をお願いする",
            },
            Optimize = {
              prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
              mapping = '<leader>Co',
              description = "コードの最適化をお願いする",
            },
            Docs = {
              prompt = "/COPILOT_GENERATE 選択したコードに関するドキュメントコメントを日本語で生成してください。",
              mapping = '<leader>Cd',
              description = "コードのドキュメント作成をお願いする",
            },
            Tests = {
              prompt = "/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
              mapping = '<leader>Ct',
              description = "テストコード作成をお願いする",
            },
            FixDiagnostic = {
              prompt = 'コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします。',
              mapping = '<leader>Ci',
              description = "コードの修正をお願いする",
              selection = require('CopilotChat.select').diagnostics,
            },
            Commit = {
              prompt =
              '実装差分に対するコミットメッセージを日本語で記述してください。',
              mapping = '<leader>Cco',
              description = "コミットメッセージの作成をお願いする",
              selection = require('CopilotChat.select').gitdiff,
            },
            CommitStaged = {
              prompt =
              'ステージ済みの変更に対するコミットメッセージを英語で記述してください。',
              mapping = '<leader>Cs',
              description = "ステージ済みのコミットメッセージの作成をお願いする",
              selection = function(source)
                return require('CopilotChat.select').gitdiff(source, true)
              end,
            },
          },
        })
      end, 100)
      lvim.builtin.which_key.mappings["C"] = {
        name   = "Copilot",
        e      = { "", "コード説明" },
        r      = { "", "レビュー" },
        f      = { "", "バグ修正案" },
        o      = { "", "最適化" },
        d      = { "", "ドキュメント生成" },
        t      = { "", "テストコード生成" },
        i      = { "", "診断修正" },
        s      = { "", "コミットメッセージ作成(ステージ済み)" },
        ["co"] = { "", "コミットメッセージ作成(実装差分)" },
      }
    end,
  },

  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { enabled = false }
    end,
  },
  {
    "folke/lsp-colors.nvim",
    event = "BufRead",
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_auto_start = 0
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
    "tpope/vim-surround",
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
  {
    "tpope/vim-rails",
  },
  {
    "ellisonleao/gruvbox.nvim", priority = 1000, config = true
  },
  {
    "nomnivore/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    -- All the user commands added by the plugin
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

    keys = {
      -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
      {
        "<leader>oo",
        ":<c-u>lua require('ollama').prompt()<cr>",
        desc = "ollama prompt",
        mode = { "n", "v" },
      },

      -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
      {
        "<leader>og",
        ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
        desc = "ollama Generate Code",
        mode = { "n", "v" },
      },
    },

    config = function()
      lvim.builtin.which_key.mappings["o"] = {
        name = "Ollama",
        o    = { "", "ollamaプロンプト" },
        g    = { "", "コード生成" },
      }
    end,
  },
  {
    "andres-lowrie/vim-sqlx",
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { enabled = false }
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    event = "BufRead",
    config = function()
      require("gitlinker").setup {
        opts = {
          -- remote = 'github', -- force the use of a specific remote
          -- adds current line nr in the url for normal mode
          add_current_line_on_normal_mode = true,
          -- callback for what to do with the url
          action_callback = require("gitlinker.actions").open_in_browser,
          -- print the url after performing the action
          print_url = false,
          -- mapping to call url generation
          mappings = "<leader>gy",
        },
      }
    end,
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  {
    "iberianpig/tig-explorer.vim",
    dependencies = { "rbgrouleff/bclose.vim" },
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
      vim.g.db_ui_save_location = vim.fn.expand("~/work/kufu-ai/iyuuya-private/exam/saved")
    end
  },
  {
    "sato-s/telescope-rails.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      lvim.builtin.which_key.mappings["r"] = {
        name = "Rails",
        m = { "<cmd>Telescope rails models<cr>", "model" },
        c = { "<cmd>Telescope rails controllers<cr>", "controller" },
        v = { "<cmd>Telescope rails views<cr>", "view" },
        s = { "<cmd>Telescope rails specs<cr>", "spec" },
      }
    end
  },
}

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "rails")
end
