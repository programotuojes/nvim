require("gustas.options")
require("gustas.remaps")

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath, }
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("User", {
  pattern = "LazySync",
  callback = function()
    local flutter_folder = vim.fn.stdpath "data" .. "/lazy/flutter-tools.nvim"
    local patch = vim.fn.stdpath "config" .. "patches/flutter-nixos.patch"
    local output = vim.fn.system { "patch", "-p1", "-r", "-", "-N", "-s", "-d", flutter_folder, "-i", patch, }
    print("res" .. output)
    print(vim.v.shell_error)
  end,
})

require("lazy").setup("plugins", {
   change_detection = {
        notify = false
    }
})
