return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- OR setup with some options
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 48,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })

      vim.api.nvim_set_keymap("n", "<leader>ef", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
}
