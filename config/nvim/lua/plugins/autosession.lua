return {

    -- auto-session: saves current session state and reloads it
    -- when nvim resumes
    {
        'rmagatti/auto-session',
        config = function()
            require("auto-session").setup({
                log_level = "error",
                auto_save_enabled = true,
                auto_restore_enabled = true,
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
            })
        end
    },
}
