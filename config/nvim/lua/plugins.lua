-- Downloads and installs packer if-need-be
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({function(use)
    use 'wbthomason/packer.nvim'  -- auto-managed packer

    -- Use G<git-cmd> to check git command outputs on neovim
    use 'tpope/vim-fugitive'

    -- Figures out white-space and tab-stops cleverly
    use 'tpope/vim-sleuth'

    -- Functions for doing case-persistant substitutions
    use 'vim-scripts/keepcase.vim'

    -- Snippet support
    use 'honza/vim-snippets'

    -- Powerline support in neovim
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Themes
    use 'EdenEast/nightfox.nvim'    -- nightfox themes
    use 'ellisonleao/gruvbox.nvim'  -- gruvbox theme
    use {'folke/tokyonight.nvim', branch = 'main'}  -- tokyonight theme

    -- Displays a popup with possible key bindings of the command you started
    -- typing
    use {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
            }
        end
    }

    -- Adds gutter signs for git changes
    use 'airblade/vim-gitgutter'

    -- Cause all trailing whitespace characters to be highlighted
    use 'ntpeters/vim-better-whitespace'

    -- "gc" to comment visual regions/lines
    use 'numToStr/Comment.nvim'

    -- Helps typesetting LaTeX
    use 'lervag/vimtex'

    -- Auto-indent/re-indent Python files
    use {'psf/black', tag='stable'}

    -- Overlay window system for various activities: searching files, buffers,
    -- completions, etc.
    use {'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Code parser for neovim allows code highlighting, edition, and navigation
    use {'nvim-treesitter/nvim-treesitter',
        requires = { 'nvim-treesitter/nvim-treesitter-textobjects', opt = true },
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end
    }

    use {'neoclide/coc.nvim', branch='release'}

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end,
config = {
    compile_path = vim.fn.stdpath('data') .. '/packer_compiled.lua',
    display = {
        open_cmd = 'new \\[packer\\]',
    }
}})
