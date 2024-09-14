local Input = require("nui.input")

---@class TextInput: NuiInput
local TextInput = Input:extend("ZonkanInput")

---@param value string
function TextInput:set_value(value)
	if self._last_value == value then
		return
	end
	vim.defer_fn(function()
		vim.api.nvim_buf_set_lines(self.bufnr, 0, 1, false, { "> " .. value })
		vim.api.nvim_win_set_cursor(self.winid, { 1, #"> " + #value })
		self._last_value = value
	end, 1)
end
function TextInput:init(popup_options, options)
	TextInput.super.init(self, popup_options, options)
	local internal_on_change = self._.on_change
	self._.on_change = function(value)
		self._last_value = value
		if internal_on_change then
			internal_on_change(value)
		end
	end
end

return TextInput
