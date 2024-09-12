local window = require("zonkan.window")

local auto_command_group = vim.api.nvim_create_augroup("ZonkanInitial", { clear = true })

local function read_db() end

local function main()
	read_db()
	vim.keymap.set("n", "Z", function()
		window.new()
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
