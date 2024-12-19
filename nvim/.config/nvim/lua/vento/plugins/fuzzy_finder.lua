return {
  "junegunn/fzf",
  {
    "junegunn/fzf.vim",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>ff", ":FZF<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>fg", ":GFiles<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>fb", ":Buffers<CR>", { noremap = true, silent = true })
    end,
  }
}
