local window = require("zonkan.window")
local Input = require("zonkan.ui.input")

local auto_command_group = vim.api.nvim_create_augroup("ZonkanInitial", { clear = true })

local function read_db() end

local function create_project()
	local popup_options = {
		relative = "editor",
		position = {
			row = "50%",
			col = "50%",
		},
		size = 20,
		border = {
			style = "rounded",
			text = {
				top = "Project name",
				top_align = "left",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal",
		},
	}
	local input
	input = Input(popup_options, {
		prompt = "> ",
		default_value = "",
		on_close = function()
			print("Input closed!")
		end,
		on_submit = function(value)
			print("Value submitted: ", value)
		end,
		on_change = function(value)
			print("Value changed: ", value)
			input:set_value("69")
		end,
	})
	input:mount()
end

local function main()
	read_db()
	vim.keymap.set("n", "Z", function()
		-- window.new()
		create_project()
	end)
end

local function setup()
	vim.api.nvim_create_autocmd("BufEnter", {
		group = auto_command_group,
		desc = "Read DataBase on load",
		once = true,
		callback = main,
	})
end

return { setup = setup }
