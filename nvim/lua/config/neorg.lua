
local neorg = require('neorg')

neorg.setup{
    load = {
	["core.defaults"] = {},
	["core.norg.concealer"] = {},
	["core.norg.dirman"] ={
	    config = {
		workspaces = {
		    code = "~/code/norg",
		    projects = "~/code/prjs/norg"
		}
	    }
	}
	}
}
