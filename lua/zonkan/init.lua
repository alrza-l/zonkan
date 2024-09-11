local auto_command_group = vim.api.nvim_create_augroup("ZONKAN", { clear = true })

local function draw_window()
	local buffer = vim.api.nvim_create_buf(false, true)
	local window_width = vim.api.nvim_get_option_value("columns", {})
	local window_height = vim.api.nvim_get_option_value("columns", {})

	local width = math.ceil(window_width * 0.8)
	local height = math.ceil(window_height * 0.8)

	local row = math.ceil((window_height - height) / 2 - 1)
	local col = math.ceil((window_width - width) / 2)

	local window_opts = {
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		relative = "editor",
	}

	-- vim.api.nvim_buf_set_name(buffer, "zonkan-buffer")
	win = vim.api.nvim_open_win(buffer, true, window_opts)
	vim.api.nvim_buf_set_option(buffer, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buffer, "filetype", "whid")
end

local function read_db()
	local buffer = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_name(buffer, "zonkan-buffer")
	vim.api.nvim_set_option_value("filetype", "lua", { buf = buffer })
	vim.api.nvim_win_set_buf(0, buffer)
	local content = { "0: Alireza", "1: Sina" }
	vim.api.nvim_buf_set_lines(buffer, 0, -1, false, content)
	return buffer
end

local function main()
	read_db()
	vim.keymap.set("n", "z", function()
		draw_window()
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
