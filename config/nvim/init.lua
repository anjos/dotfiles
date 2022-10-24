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

-- These are our plugins and their configuration
require('plugins')

-- Changes editor behaviour, key bindings, etc
require('behaviour')

-- Color settings and overall look and feel
require('theme')

-- Configuration for ultisnips
vim.g.ultisnips_python_style = 'sphinx'
vim.g.ultisnips_python_quotion_style = 'double'

-- look for the "theme/" on latex builds
vim.env.TEXINPUTS = vim.env.PWD .. ':' .. vim.env.PWD .. '/theme:'

-- use nvr (required by vim-tex)
vim.g.vimtex_compiler_progname = conda_env .. '/bin/nvr'
vim.g.vimtex_view_method = 'skim'
vim.g.tex_flavor = 'latex'

-- configuration for Black (Python)
vim.g.black_linelength = 80

-- opens chooser window from telescope
vim.keymap.set('n', '<C-a>', ':lua require("telescope.builtin").find_files({layout_strategy="flex",layout_config={width=0.9,height=0.9}})<cr>', {noremap=true, silent=true})

-- language server setup
vim.opt.updatetime = 300
vim.g.coc_node_path = conda_env .. '/bin/node'
vim.g.coc_global_extensions = {
    'coc-pyright',
    'coc-sh',
    'coc-vimlsp',
    'coc-texlab',
    'coc-lua',
    'coc-css',
    'coc-calc',
    'coc-json',
    'coc-snippets',
}

-- Auto complete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: There's always complete item selected by default, you may want to enable
-- no select by `"suggest.noselect": true` in your configuration file.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
vim.keymap.set("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
vim.keymap.set("i", "<C-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion.
vim.keymap.set("i", "<C-space>", "coc#refresh()", {silent = true, expr = true})

-- Tree-sitter configuration (highlight, indentation and folding)
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  -- Use :TSInstallInfo to check what is available
  ensure_installed = {
      "bash",
      "bibtex",
      "c",
      "cmake",
      "comment",
      "diff",
      "dockerfile",
      "dot",
      "html",
      "json",
      "jsonc",
      "latex",
      "lua",
      "make",
      "markdown",
      "python",
      "toml",
      "vim",
      "yaml",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {enable = true},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same
    -- time. Set this to `true` if you depend on 'syntax' being enabled (like
    -- for indentation). Using this option may slow down your editor, and you
    -- may see some duplicate highlights. Instead of true it can also be a list
    -- of languages
    additional_vim_regex_highlighting = false,
}
