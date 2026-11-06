require 'main.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazylazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
	{ import = 'plugins' },
}

vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")

