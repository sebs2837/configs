local lsp = require('lsp-zero').preset({})

require("lsp-colors").setup({
	Error = "#db4b4b",
	Warning = "#D8DD4F",
	Information = "#0db9d7",
	Hint = "#6CA4BE"
})

--lsp.preset("recommended")
--[[
lsp.ensure_installed({
    'rust_analyzer',
    'lua_ls',
})
]]--
--local on_attach = function(client, bufnr)
lsp.on_attach(function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
    --	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local map = vim.keymap.set
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', bufopts)
	map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', bufopts)
	map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', DEFAULT_OPTIONS)
	map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', bufopts)
	map('n', '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<cr>', bufopts)
	map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', bufopts)
	map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', bufopts)
	map('n', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', bufopts)
	map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', bufopts)
	map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', bufopts)
	map('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', bufopts)
	map('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename<cr>', bufopts)
	map('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<cr>', bufopts)
	map('n', '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<cr>', bufopts)
	map('n', '<leader>vf', '<cmd>lua vim.lsp.buf.format()<cr>', bufopts)
	if client.name == 'rust' then
		map("n", "<C-leader>", require('rust-tools').hover_actions.hover_actions, bufopts)
	end
end)

--lsp.nvim_workspace()
--lsp.setup()

--[[
nvim_lsp.vimls.setup {
	on_attach = on_attach,
}

nvim_lsp.gopls.setup {
	on_attach = on_attach,
}

nvim_lsp.clangd.setup {
	on_attach = on_attach,
}

nvim_lsp.cmake.setup {
	on_attach = on_attach,
}

nvim_lsp.julials.setup {
	on_attach = on_attach,
}
]]--

lsp.configure('pylsp', {
   -- on_attach = on_attach,
    settings = {
        pylsp = {
            plugins = {
                pylint = {
                    enabled = true,
                    args = {"--disable=C0116,W1203,C0114"},
                    executable = "pylint"
                },
                pyflakes = { enabled = false },
                pycodestyles = { enabled = false },
                jedi_completion = {enabled = true},
                jedi_hover = {enabled = true},
                jedi_references = {enabled = true},
                jedi_signature_help = {enabled = true},
                jedi_symbols = {enabled = true, all_scopes = true},
                pyls_isort = { enabled = true, profile = "black" },
                pylsp_mypy = { enabled = true },
                pylsp_black = {
                    enable = true,
                    line_length = 120
                },
            },
        },
    },
    flags = {
        debounce_text_changes = 200,
    },
})

lsp.configure('lua_ls', {
	--on_attach = on_attach,
})

lsp.configure('clangd', {
    --on_attach = on_attach,
})

local opts = {
	tools = { -- rust-tools options
		autoSetHints = true,
		inlay_hints = {

			-- Only show inlay hints for the current line
			only_current_line = false,

			-- Event which triggers a refersh of the inlay hints.
			-- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
			-- not that this may cause  higher CPU usage.
			-- This option is only respected when only_current_line and
			-- autoSetHints both are true.
			only_current_line_autocmd = "CursorHold",

			-- wheter to show parameter hints with the inlay hints or not
			show_parameter_hints = true,

			-- prefix for parameter hints
			parameter_hints_prefix = "<- ",

			-- prefix for all the other hints (type, chaining)
			other_hints_prefix = "=> ",

			-- whether to align to the length of the longest line in the file
			max_len_align = false,

			-- padding from the left if max_len_align is true
			max_len_align_padding = 1,

			-- whether to align to the extreme right or not
			right_align = false,

			-- padding from the right if right_align is true
			right_align_padding = 7,

			-- The color of the hints
			highlight = "SpecialComment",
		},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
	server = {
		-- on_attach is a callback called when the language server attachs to the buffer
	--	on_attach = function ()
		-- Hover actions
		--	  vim.keymap.set("n", "<C-leader>", require('rust-tools').hover_actions.hover_actions, { buffer = bufnr })
		-- Code action groups
		--	  vim.keymap.set("n", "<Leader>a", require('rust-tools').code_action_group.code_action_group, { buffer = bufnr })
		settings  = {
			-- to enable rust-analyzer settings visit:
			-- https://github.com/rust-aalyzer/rust-analyzero blob/master/docs/user/generated_config.adoc
			["rust-analyzer"] = {
				-- enable clippy on save
				checkOnSave = {
					command = "clippy"
				},
			}
		}
	},
}

--lsp.configure('rust_analyzer',opts)


require('rust-tools').setup(opts)

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local lspkind = require('lspkind')
local cmp = require 'cmp'
cmp.setup({
	-- Enable LSP snippets
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)

		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		-- Add tab support
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-leader>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		})
	},

    -- format actions to get icons
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function (entry, vim_item)
                return vim_item
            end
        })
    },

	-- Installed sources
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'path' },
		{ name = 'buffer' },
	},
})
lsp.setup()
