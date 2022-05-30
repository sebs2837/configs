 -- Lua lsp setup
local system_name = ''
local USER = vim.fn.expand('$USER')
local sumneko_root_path = "/Users/" ..USER.. "/code/lua/lua-language-server"

if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local nvim_lsp = require'lspconfig'

require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#D8DD4F",
  Information = "#0db9d7",
  Hint = "#6CA4BE"
})

nvim_lsp.vimls.setup{}
nvim_lsp.gopls.setup{}
nvim_lsp.clangd.setup{}
nvim_lsp.cmake.setup{}
nvim_lsp.julials.setup{}
nvim_lsp.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
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
        globals = {'vim'},
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
}

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
	inlay_hints = {

            -- Only show inlay hints for the current line
            only_current_line = true,

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
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-aalyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}


require('rust-tools').setup(opts)

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration

local cmp = require'cmp'
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
    ['<C-Space>'] = cmp.mapping.complete(),
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

-- Key mappings 
local map = vim.api.nvim_set_keymap
local default_options = { noremap = true, silent = true }
local expr_options = { noremap = true, expr = true, silent = true }

map("n", "<c-]>", "<Cmd>lua vim.lsp.buf.definition()<CR>", default_options)
map("n", "K",     "<Cmd>lua vim.lsp.buf.hover()<CR>,", default_options)
map("n", "gD",    "<Cmd>lua vim.lsp.buf.implementation()<CR>", default_options)
map("n", "<c-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", default_options)
map("n", "1gD",   "<Cmd>lua vim.lsp.buf.type_definition()<CR>", default_options)
map("n", "gr",    "<Cmd>lua vim.lsp.buf.references()<CR>", default_options)
map("n", "g0",    "<Cmd>lua vim.lsp.buf.document_symbol()<CR>", default_options)
map("n", "gW",    "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>", default_options)
map("n", "gd",    "<Cmd>lua vim.lsp.buf.definition()<CR>", default_options)
map("n", "ga",    "<Cmd>lua vim.lsp.buf.code_action()<CR>", default_options)
