-- This is the base conda environment where utilities for neovim are installed
vim.g.conda_env_root = '/Users/andre/mamba/envs/neovim'

-- These are important environment variables
vim.env.PATH = vim.env.PATH .. ':' .. vim.g.conda_env_root .. '/bin'
vim.env.GEM_HOME = vim.g.conda_env_root .. '/share/rubygems'
vim.env.GOROOT = vim.g.conda_env_root .. '/go'

-- Sets up some paths
vim.g.loaded_perl_provider = 0 -- disables pearl support
vim.g.loaded_python_provider = 0 -- disables python2 support
vim.g.python3_host_prog = vim.g.conda_env_root .. '/bin/python3'
vim.g.ruby_host_prog = vim.g.conda_env_root .. '/bin/neovim-ruby-host'
vim.g.node_host_prog = vim.g.conda_env_root .. '/lib/node_modules/neovim/bin/cli.js'

-- Set semi-colon as the leader key, see `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will
--  be used)
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

-- Plugin management
-- Installs package manager (https://github.com/folke/lazy.nvim)
-- `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup('plugins')

-- These control the editor's colorscheme (theme)
require('colorscheme')

-- These control the behaviour of neovim
require('behaviour')
