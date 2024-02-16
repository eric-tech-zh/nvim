local lspsaga = require("lspsaga")
lspsaga.setup({ -- defaults ...
	devicon = true,
	imp_sign = "󰳛 ",
	code_action = {
		num_showcut = true,
		show_server_name = false,
		keys = {
			quit = "q",
			exec = "<CR>",
		},
	},
	lightbulb = {
		enable = true,
		enable_in_insert = true,
		sign = true,
		sign_priority = 40,
		virtual_text = true,
	},
	rename = {
		quit = "<C-c>",
		exec = "<CR>",
		mark = "x",
		confirm = "<CR>",
		in_select = true,
	},
	symbol_in_winbar = {
		enable = true,
		separator = "/",
		ignore_patterns = {},
		hide_keyword = true,
		show_file = true,
		folder_level = 2,
		respect_root = false,
		color_mode = true,
	},
})
