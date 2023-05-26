local conda_env = '/Users/andre/mamba/envs/neovim'

-- These are important environment variables
vim.env.PATH = vim.env.PATH .. ':' .. conda_env .. '/bin'
vim.env.GEM_HOME = conda_env .. '/share/rubygems'

-- Sets up some paths
vim.g.loaded_perl_provider = 0  -- disables pearl support
vim.g.loaded_python_provider = 0  -- disables python2 support
vim.g.python3_host_prog = conda_env .. '/bin/python3'
vim.g.ruby_host_prog = conda_env .. '/bin/neovim-ruby-host'
vim.g.node_host_prog = conda_env .. '/lib/node_modules/neovim/bin/cli.js'
-- vim.opt.coc_node_path = conda_env .. '/bin/node'

-- Set semi-colon as the leader key, see `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will
--  be used)
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

-- These are our plugins and their configuration
require('plugins')

-- These are paths that are affecting some of our plugins
vim.g.vimtex_compiler_progname = conda_env .. '/bin/nvr'
vim.g.coc_node_path = conda_env .. '/bin/node'

-- Changes editor behaviour, key bindings, etc
require('behaviour')

-- Color settings and overall look and feel
require('theme')

-- Coding preferences for completions, code highlightning
require('coding')
