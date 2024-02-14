local config = function()
    local lspsaga = require 'lspsaga'

    lspsaga.setup { -- defaults ...
        use_saga_diagnostic_sign = true,
        error_sign = " ",
        warn_sign = " ",
        hint_sign = " ",
        infor_sign = " ",
        diagnostic_header_icon = "   ",
        code_action_icon = " ",
        code_action_prompt = {
            enable = true,
            sign = true,
            sign_priority = 40,
            virtual_text = true,
        },
        finder_definition_icon = "  ",
        finder_reference_icon = "  ",
        max_preview_lines = 10,
        finder_action_keys = {
            open = "o",
            vsplit = "s",
            split = "i",
            quit = "q",
            scroll_down = "<C-f>",
            scroll_up = "<C-b>",
        },
        rename_action_keys = {
            quit = "<C-c>",
            exec = "<CR>",
        },
        definition_preview_icon = "  ",
        border_style = "single",
        rename_prompt_prefix = "➤",
        server_filetype_map = {},
        diagnostic_prefix_format = "%d. ",
    }
    vim.keymap.set("n", "<leader>sh", "<cmd> Lspsaga lsp_finder<CR>",
        { noremap = true, silent = true, desc = "search all symbols" })                                               -- search all symbols
    vim.keymap.set({ "n", "v" }, "<leader>sc", "<cmd> Lspsaga code_action<CR>",
        { noremap = true, silent = true, desc = "code action" })                                                      -- perform code action
    vim.keymap.set("n", "<leader>sr", "<cmd> Lspsaga rename<CR>", { noremap = true, silent = true, desc = "rename" }) -- rename
    --vim.keymap.set("n", "<leader>sd", "<cmd> Lspsaga peek_definition<CR>", DEFAULT_OPTIONS) -- definition needs floatterm


    -- Show line diagnostics
    vim.keymap.set("n", "<leader>sld", "<cmd>Lspsaga show_line_diagnostics<CR>",
        { noremap = true, silent = true, desc = "show line diagnostics" })

    -- Show cursor diagnostic
    vim.keymap.set("n", "<leader>sd", "<cmd>Lspsaga show_cursor_diagnostics<CR>",
        { noremap = true, silent = true, desc = "show diagnostics under cursor" })

    -- Diagnsotic jump can use `<c-o>` to jump back
    vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>",
        { noremap = true, silent = true, desc = "next diag message" })
    vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>",
        { noremap = true, silent = true, desc = "previous diag message" })

    -- Only jump to error
    vim.keymap.set("n", "[E", function()
        require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { noremap = true, silent = true, desc = "next error" })
    vim.keymap.set("n", "]E", function()
        require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { noremap = true, silent = true, desc = "previous error"
    })

    -- Outline
    vim.keymap.set("n", "<leader>so", "<cmd>Lspsaga outline<CR>",
        { noremap = true, silent = true, desc = "show outline" })

    -- Hover Doc
    vim.keymap.set("n", "<leader>sk", "<cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true, desc = "show docs" })
end
return {
    {
        "kkharji/lspsaga.nvim",
        event = "LspAttach",
        config = config
    }
}
