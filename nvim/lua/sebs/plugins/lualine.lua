local LSPIcon = {}
LSPIcon = {
    lua_ls = { icon = "" },
    rust_analyzer =  { icon = "" },
    zls = { icon = "" },
    julials = { icon = "" },
    gopls= {icon = ""},
    ts_ls = { icon = "" },
}


local function get_icon()
    return LSPIcon:to_string()
end

function LSPIcon:to_string()
    local bufnr = vim.api.nvim_get_current_buf()
    local client = vim.lsp.get_clients({bufnr= bufnr})
    local msg = "  LSP: "
    for _, c in  ipairs(client) do
        print("Name " ..c.name)
    end

    if client ~= nil then
        local name = client.name

        local icon = LSPIcon[name].cfg.icon
        print("msg " .. icon)
        local m = msg .. icon
        print("msg " ..m)
        return ""..msg .. icon..""
    else
        return msg .. "No active clietnt"
    end
end

local config = function()
    local lualine = require('lualine')

    -- Color table for highlights
    -- stylua: ignore
    local colors = {
        bg       = '#414863',
        fg       = '#bbc2cf',
        yellow   = '#ECBE7B',
        cyan     = '#008080',
        darkblue = '#081633',
        green    = '#98be65',
        orange   = '#FF8800',
        violet   = '#a9a1e1',
        magenta  = '#c678dd',
        blue     = '#51afef',
        red      = '#ec5f67',
    }

    local conditions = {
        buffer_not_empty = function()
            return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
        hide_in_width = function()
            return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
            local filepath = vim.fn.expand('%:p:h')
            local gitdir = vim.fn.finddir('.git', filepath .. ';')
            return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
    }

    -- Config
    local config = {
        options = {
            -- Disable sections and component separators
            component_separators = '',
            section_separators = '',
            theme = "rose-pine",
        },
        sections = {
            -- these are to remove the defaults
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            -- These will be filled later
            lualine_c = {},
            lualine_x = {},
        },
        inactive_sections = {
            -- these are to remove the defaults
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
        },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x to right section
    local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
    end

    local function mode_color()
        local color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        return { fg = color[vim.fn.mode()] }
    end

    ins_left {
        function()
            return '▊'
        end,
        color = mode_color,                -- Sets highlighting of component
        padding = { left = 0, right = 1 }, -- We don't need space before this
    }

    ins_left {
        -- mode component
        function()
            return ''
        end,
        color = mode_color,
        padding = { right = 1 },
    }

    ins_left {
        -- filesize component
        'filesize',
        cond = conditions.buffer_not_empty,
    }

    ins_left {
        'filename',
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, gui = 'bold' },
    }

    ins_left { 'location' }

    ins_left { function()
        local bufs = vim.api.nvim_list_bufs()
        local count = -1

        for _, buf in  pairs(bufs) do
           if vim.api.nvim_buf_is_valid(buf) then
             count = count + 1
           end
        end
        return ' '.. count 

    end
    }

    ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

    ins_left {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
            color_error = { fg = colors.red },
            color_warn = { fg = colors.yellow },
            color_info = { fg = colors.cyan },
        },
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
        function()
            return '%='
        end,
    }

    ins_left {
        -- Lsp server name .
            function()
            local msg = 'No Active Lsp'
            local buf_ft = vim.api.nvim_get_option_value('filetype', {buf = 0})
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
                return msg
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return LSPIcon[client.name].icon.." ".. client.name
                end
            end
            return msg
        end,
        icon = '',
        color = { fg = '#ffffff', gui = 'bold' },
    }


    -- Add components to right sections
    ins_right {
        'o:encoding',       -- option component same as &encoding in viml
        fmt = string.upper, -- I'm not sure why it's upper case either ;)
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = 'bold' },
    }

    ins_right {
        'fileformat',
        fmt = string.upper,
        icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
        color = { fg = colors.green, gui = 'bold' },
    }

    ins_right {
        'branch',
        icon = '',
        color = { fg = colors.violet, gui = 'bold' },
    }

    ins_right {
        'diff',
        -- Is it me or the symbol for modified us really weird
        symbols = { added = ' ', modified = ' ', removed = ' ' },
        diff_color = {
            added = { fg = colors.green },
            modified = { fg = colors.orange },
            removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
    }

    ins_right {
        function()
            return '▊'
        end,
        color = mode_color,
        padding = { left = 1 },
    }

    -- Now don't forget to initialize lualine
    lualine.setup(config)
end
return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        config = config,
        dependencies = { "kyazdani42/nvim-web-devicons", opt = true }
    }
}
