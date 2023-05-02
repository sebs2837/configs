
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = true }
	map('n', 'gD', vim.lsp.buf.declaration, bufopts)
	map('n', 'gd', vim.lsp.buf.definition, bufopts)
	map('n', 'K', vim.lsp.buf.hover, bufopts)
	map('n', 'gi', vim.lsp.buf.implementation, bufopts)
	map('n', '<leader>vd', vim.diagnostic.open_float, DEFAULT_OPTIONS)
	map('n', ']d', vim.diagnostic.goto_next, bufopts)
	map('n', '[d', vim.diagnostic.goto_prev, bufopts)
	map('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
	map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	map('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	map('n', '<leader>vrn', vim.lsp.buf.rename, DEFAULT_OPTIONS)
	map('n', '<leader>vca', vim.lsp.buf.code_action, bufopts)
	map('n', '<leader>vrr', vim.lsp.buf.references, bufopts)
	map('n', '<leader>vf', vim.lsp.buf.format, bufopts)
	if client.name == 'rust' then
		map("n", "<C-leader>", require('rust-tools').hover_actions.hover_actions, bufopts)
	end
end
-- Lua lsp setup
local USER = vim.fn.expand('$USER')

if not vim.fn.executable('lua-language-server') == 1 then
local sumneko_root_path = "/Users/" .. USER .. "/tools/lua-language-server"

-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
else
local sumneko_binary = 'lua-language-server'
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")


--local nvim_lsp = require('lsp-zero')
local lsp = require('lsp-zero')

require("lsp-colors").setup({
	Error = "#db4b4b",
	Warning = "#D8DD4F",
	Information = "#0db9d7",
	Hint = "#6CA4BE"
})

lsp.preset("recommended")
lsp.ensure_installed({
    'rust_analyzer',
    'sumneko_lua',
})

lsp.nvim_workspace()
lsp.setup()

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
	on_attach = on_attach,
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

lsp.configure('sumneko_lua', {
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
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
		on_attach = on_attach,
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

	-- Installed sources
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'path' },
		{ name = 'buffer' },
	},
})