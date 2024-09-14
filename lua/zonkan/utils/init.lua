---@param input_str string
---@param delimiter string
local function split_string(input_str, delimiter)
	local result = {}
	for match in (input_str .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end
	return result
end

return {
	split_string = split_string,
}
