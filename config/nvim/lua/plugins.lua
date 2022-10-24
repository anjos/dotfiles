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
    use 'wbthomason/packer.nvim'  -- auto-managed packed

    -- Other plugins from here...
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'vim-scripts/keepcase.vim'
    use 'honza/vim-snippets'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'EdenEast/nightfox.nvim'
    use 'nathanaelkane/vim-indent-guides'
    use 'lervag/vimtex'
    use {'psf/black', tag='stable'}

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end
    }

    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
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
