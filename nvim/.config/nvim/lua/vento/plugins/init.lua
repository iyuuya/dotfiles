local ensure_packer = function()
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print("Installing packer.nvim")
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.api.nvim_command("packadd packer.nvim")
    return true
  end

  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  require("vento/plugins/fuzzy_finder").setup(use)
  require("vento/plugins/filetype").setup(use)
  require("vento/plugins/colorscheme").setup(use)
  require("vento/plugins/treesitter").setup(use)
  require("vento/plugins/filer").setup(use)
  require("vento/plugins/cmp").setup(use)
  require("vento/plugins/dev").setup(use)

  if packer_bootstrap then
    require("packer").sync()
  end
end)
