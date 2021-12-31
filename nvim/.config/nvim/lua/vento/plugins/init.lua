local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print("Installing packer.nvim")
  vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path
  })
  vim.api.nvim_command("packadd packer.nvim")
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({})

return packer.startup(function(use)
  use("wbthomason/packer.nvim")
  use("lotabout/skim")
  use("lotabout/skim.vim")
end)
