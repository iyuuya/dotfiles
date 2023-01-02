local fuzzy_finder = {
  setup = function(use)
    -- FuzzyFinder
    use("lotabout/skim")
    use("lotabout/skim.vim")
    use("junegunn/fzf")
    use("junegunn/fzf.vim")
    use({
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      end,
    })
  end
}

return fuzzy_finder
