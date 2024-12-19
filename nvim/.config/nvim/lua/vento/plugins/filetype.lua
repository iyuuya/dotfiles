return {
    "kchmck/vim-coffee-script",
    "pocke/rbs.vim",
    "tpope/vim-rails",
    {
      "crispgm/nvim-go",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
      }
    },
    "tokorom/vim-review",
    -- {
    --   "iamcco/markdown-preview.nvim",
    --   run = "cd app && npm install",
    --   setup = function()
    --     vim.g.mkdp_filetypes = { "markdown" }
    --     vim.g.mkdp_auto_start = 0
    --     vim.g.mkdp_preview_options = {
    --       ['plantuml'] = {
    --         ['imageFormat'] = 'png',
    --         ['server'] = 'http://localhost:8000/plantuml',
    --       },
    --       ['uml'] = {
    --         ['imageFormat'] = 'png',
    --         ['server'] = 'http://localhost:8000/plantuml',
    --       },
    --     }
    --   end,
    --   ft = { "markdown" }
    -- },
    "sgur/vim-editorconfig",
    "aklt/plantuml-syntax",
}
