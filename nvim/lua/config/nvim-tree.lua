local cmd = vim.cmd
local map = vim.api.nvim_set_keymap



-- local tree_cb = require"nvim-tree.config".nvim_tree_callback
require("nvim-tree").setup {
    -- 0 by default, will disable the window picker.
    -- nvim_tree_disable_window_picker = 1,
    -- disables netrw completely
    disable_netrw = true,
    -- hijack netrw window on startup
    hijack_netrw = true,
    -- open the tree when running this setup function
    open_on_setup = false,
    -- will not open on setup if the filetype is in this list
    ignore_ft_on_setup = {},
    -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    open_on_tab = true,
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor = false,
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    respect_buf_cwd = false, -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.

    update_cwd = true,
    -- show lsp diagnostics in the signcolumn
    diagnostics = {
        enable = true,
        icons = {hint = "", info = "", warning = "", error = ""}
    },
    hijack_directories = {
      enable = true,
      auto_open = false,
    },
    filters = {
      dotfiles = true, -- dont show dot files
      custom = {},
      exclude = {},
    },
    renderer = {
        add_trailing = true, -- 0 by default, append a trailing slash to folder names
        group_empty = true, --  0 by default, compact folders that only contain a single folder into one node in the file tree
        highlight_git = true, -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
        highlight_opened_files = "file", -- 0 by default, will enable folder and file icon highlight for opened files/directories.
	root_folder_modifier = ":~", -- This is the default. See :help filename-modifiers for more options
        indent_markers = {
          enable = false,
	},
	icons = {
	  webdev_colors = true,
	  padding = " ", -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
	  symlink_arrow = " ➜ ", --  defaults to ' ➛ '. used as a separator between symlinks' source and target.
	  show = {git = true, folder = true, file = true, folder_arrow = true},
          glyphs = {
	    default = "",
	    symlink = "",
	    git = {
		unstaged = "",
		staged = "✓",
		unmerged = "",
		renamed = "➜",
		deleted = "",
		untracked = "U",
		ignored = "◌"
	    },
	    folder = {
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = ""
	    }
	  },
	},
    },
    git = {ignore = true},
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    update_focused_file = {
        -- enables the feature
        enable = true,
        -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
        -- only relevant when `update_focused_file.enable` is true
        update_cwd = true,
        -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
        -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
        ignore_list = {".git", "node_modules", ".cache"}
    },
    -- configuration options for the system open command (`s` in the tree by default)
    system_open = {
        -- the command to run this, leaving nil should work in most cases
        cmd = nil,
        -- the command arguments as a list
        args = {}
    },

    trash = {cmd = "trash-put"},

    view = {
        -- show line numbers in tree disabled
        number = false,
        relativenumber = false,
        -- width of the window, can be either a number (columns) or a string in `%`
        width = 30,
        -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
        side = "left",
        -- if true the tree will resize itself after opening a file
        auto_resize = false,
	--[[
        mappings = {
            -- custom only false will merge the list with the default mappings
            -- if true, it will only use your list to set the mappings
            custom_only = true,
            -- list of mappings to set on the tree manually
            list = {
                {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")},
                {key = {"<2-RightMouse>", "<C-]>"}, cb = tree_cb("cd")},
                {key = "<C-v>", cb = tree_cb("vsplit")},
                {key = "<C-x>", cb = tree_cb("split")},
                {key = "<C-t>", cb = tree_cb("tabnew")},
                {key = "<", cb = tree_cb("prev_sibling")},
                {key = ">", cb = tree_cb("next_sibling")},
                {key = "P", cb = tree_cb("parent_node")},
                {key = "<BS>", cb = tree_cb("close_node")},
                {key = "<S-CR>", cb = tree_cb("close_node")},
                {key = "<Tab>", cb = tree_cb("preview")},
                {key = "K", cb = tree_cb("first_sibling")},
                {key = "J", cb = tree_cb("last_sibling")},
                {key = "I", cb = tree_cb("toggle_ignored")},
                {key = "H", cb = tree_cb("toggle_dotfiles")},
                {key = "R", cb = tree_cb("refresh")},
                {key = "a", cb = tree_cb("create")},
                {key = "d", cb = tree_cb("remove")},
                {key = "r", cb = tree_cb("rename")},
                {key = "<C-r>", cb = tree_cb("full_rename")},
                {key = "x", cb = tree_cb("cut")},
                {key = "c", cb = tree_cb("copy")},
                {key = "p", cb = tree_cb("paste")},
                {key = "y", cb = tree_cb("copy_name")},
                {key = "Y", cb = tree_cb("copy_path")},
                {key = "gy", cb = tree_cb("copy_absolute_path")},
                {key = "[c", cb = tree_cb("prev_git_item")},
                {key = "]c", cb = tree_cb("next_git_item")},
                {key = "-", cb = tree_cb("dir_up")},
                {key = "s", cb = tree_cb("system_open")},
                {key = "q", cb = tree_cb("close")},
                {key = "g?", cb = tree_cb("toggle_help")}
            }
        } ]]--
    }
}

-- mapings for neovim-tree
map("n", "<Leader>q", ":NvimTreeToggle<CR>", DEFAULT_OPTIONS)
cmd[[highlight NvimTreeGitDirty guifg=#ab4642 ]]
