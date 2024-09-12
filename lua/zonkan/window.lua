Window = {}

local function append_text(buffer, text)
	local start_line = vim.api.nvim_buf_line_count(buffer)
	vim.api.nvim_buf_set_lines(buffer, start_line, start_line, false, { text })
end

function Window.new()
	local buffer = vim.api.nvim_create_buf(false, true)
	local vim_width = vim.api.nvim_get_option_value("columns", {})
	local vim_height = vim.api.nvim_get_option_value("columns", {})

	local width = math.ceil(vim_width * 0.8)
	local height = math.ceil(vim_height * 0.8)

	local row = math.ceil((vim_height - height) / 2 - 1)
	local col = math.ceil((vim_width - width) / 2)

	local window_opts = {
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		relative = "editor",
	}

	vim.api.nvim_buf_set_name(buffer, "zonkan-buffer")
	win = vim.api.nvim_open_win(buffer, true, window_opts)

	--Set window Key bindings

	vim.api.nvim_buf_set_keymap(buffer, "n", "<Esc>", ":close<CR>", { noremap = true, silent = true })
	append_text(buffer, "I Finally created a window")
	append_text(buffer, "And am able to write on it")
end

return Window
