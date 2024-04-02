local config = function()
    require('gitsigns').setup {
        signs                             = {
            add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
            change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
            delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        },
        signcolumn                        = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                             = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                            = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                         = false, -- Toggle with `:Gitsigns toggle_word_diff`
        on_attach                         = function(bufnr)
            local gs = package.loaded.gitsigns
            local map = vim.keymap.set

            map('n', '<leader>hu', gs.undo_stage_hunk,
                { noremap = true, silent = true, desc = 'undo stage hunk', buffer = bufnr })
            map('n', '<leader>hs', gs.stage_hunk,
                { noremap = true, silent = true, desc = 'stage current hunk', buffer = bufnr })
            map('v', '<leader>hr', gs.reset_hunk, { noremap = true, silent = true, desc = 'reset hunk', buffer = bufnr })
            map('n', '<leader>hR', gs.reset_buffer,
                { noremap = true, silent = true, desc = 'reset buffer', buffer = bufnr })
            map('n', '<leader>hp', gs.preview_hunk,
                { noremap = true, silent = true, desc = 'preview hunk', buffer = bufnr })
            map('n', '<leader>hb', function() gs.blame_line { full = false } end,
                { noremap = true, silent = true, desc = 'blame', buffer = bufnr })
            map('n', '<leader>hS', gs.stage_buffer, OPTIONS:desc("stage complete buffer"))
            map('n', ']h', gs.next_hunk, OPTIONS:desc("gitsigns next hunk"))
            map('n', '[h', gs.prev_hunk, OPTIONS:desc("gitsigns next hunk"))
        end,


        watch_gitdir                      = {
            interval = 1000,
            follow_files = true
        },
        attach_to_untracked               = true,
        current_line_blame                = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts           = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = {
            relative_time = false
        },
        sign_priority                     = 6,
        update_debounce                   = 100,
        status_formatter                  = nil, -- Use default
        max_file_length                   = 40000,
        preview_config                    = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        yadm                              = {
            enable = false
        },
    }
        vim.api.nvim_create_autocmd('OptionSet', {
        group = vim.api.nvim_create_augroup('SebsAuCmds', {}),
            pattern = {"diff"},
            callback = function (ev)
                return
            end,
})
end
return {
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
		{"nvim-lua/plenary.nvim"},
		{"tpope/vim-fugitive"}
	},
        config = config
    }
}

