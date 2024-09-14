local Input = require("zonkan.ui.input")
local Popup = require("nui.popup")
local Layout = require("nui.layout")
local NuiLine = require("nui.line")
local utils = require("zonkan.utils")
-- local db = require("zonkan.backend.db")

local name = ""
local tags = {}

local function on_input_close()
	name = ""
	tags = {}
end
local function on_submit()
	-- db.add_project(name, tags, vim.fn.getcwd())
end

local line = NuiLine()
line:append("Add Project", "String")

local title = Popup({
	win_options = {
		winhighlight = "Normal:Comment",
	},
})
line:render(title.bufnr, -1, 1)

local name_input
local tag_input

---@type nui_popup_options
local name_popup_options = {
	relative = "editor",
	size = {
		width = "90%",
		height = 3,
	},
	border = {
		style = "rounded",
		text = {
			top = "Project Name",
			top_align = "left",
		},
	},
	win_options = {
		winhighlight = "Normal:Comment",
	},
	enter = true,
}

---@type nui_input_options
local name_input_options = {
	prompt = "> ",
	on_close = on_input_close,
	on_change = function(value)
		name = value
	end,
}

---@type TextInput
name_input = Input(name_popup_options, name_input_options)

---@type nui_popup_options
local tag_popup_options = {
	relative = "editor",
	size = {
		width = "90%",
		height = 3,
	},
	border = {
		style = "rounded",
		text = {
			top = "Project Tags",
			top_align = "left",
		},
	},
	win_options = {
		winhighlight = "Normal:Comment",
	},
	enter = false,
}

---@type nui_input_options
local tag_input_options = {
	prompt = "> ",
	on_close = on_input_close,
	on_submit = on_submit,
	on_change = function(value)
		tags = utils.split_string(value, " ")
	end,
}

---@type TextInput
tag_input = Input(tag_popup_options, tag_input_options)

name_input:map("i", "<tab>", function()
	vim.api.nvim_set_current_win(tag_input.winid)
end, {
	noremap = true,
})
name_input:map("i", "<cr>", function()
	vim.api.nvim_feedkeys("\t", "i", false)
end, { noremap = true })

tag_input:map("i", "<tab>", function()
	vim.api.nvim_set_current_win(name_input.winid)
end, {
	noremap = true,
})

local main_layout = Layout(
	{
		position = {
			row = "50%",
			col = "50%",
		},
		size = {
			width = "90%",
			height = "40%",
		},
	},
	Layout.Box({
		Layout.Box(title, { size = 2, title = "sina" }),
		Layout.Box(name_input, { size = 3 }),
		Layout.Box(tag_input, { size = 3 }),
	}, { dir = "col" })
)

local function add_project()
	main_layout:mount()
	vim.api.nvim_set_current_win(name_input.winid)
end

return {
	add_project = add_project,
}
