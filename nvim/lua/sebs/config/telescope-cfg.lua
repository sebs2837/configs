local telescope = require'telescope'
local map = vim.api.nvim_set_keymap

local M = {}


M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = vim.env.DOTFILES,
		hidden = true,
	})
end


telescope.setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    layout_config = {
          vertical =  { width = 0.5 }
    },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-b>"] = "which_key"
      }
    }
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown"
    },
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
	["ui-select"]= {},
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
})
telescope.load_extension "file_browser"

-- Key mappings
map("n","<C-p>", "<cmd>Telescope find_files prompt_prefix=🔍<CR>", DEFAULT_OPTIONS)
map("n","<C-g>", "<cmd>Telescope git_files<CR>", DEFAULT_OPTIONS)
map("n","<C-f>", "<cmd>Telescope help_tags<CR>", DEFAULT_OPTIONS)
map("n","<leader>fg", "<cmd>Telescope live_grep<CR>",DEFAULT_OPTIONS)
map("n","<leader>tb", "<cmd>Telescope file_browser<CR>", DEFAULT_OPTIONS)
map("n","<leader>fb", "<cmd>Telescope buffers<CR>", DEFAULT_OPTIONS)


return M
