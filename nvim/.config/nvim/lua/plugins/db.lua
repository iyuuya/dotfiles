return {
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
}
