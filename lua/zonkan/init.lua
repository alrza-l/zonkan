local auto_command_group = vim.api.nvim_create_augroup("ZonkanInitial", { clear = true })

local function append_text(buffer, text)
	local start_line = vim.api.nvim_buf_line_count(buffer)
	vim.api.nvim_buf_set_lines(buffer, start_line, start_line, false, { text })
end

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
	append_text(buffer, "I Finally created a window")
	append_text(buffer, "And am able to write on it")
end

local function read_db() end

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
