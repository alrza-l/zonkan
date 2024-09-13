require("zonkan.backend.fuzzy_search")

DataBase = {}

local data_file_path = vim.fn.stdpath("data") .. "/zonkan/data.json"

local function exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			return false -- premission denied
		end
	end
	return ok, err
end

local function get_data_file()
	local data = vim.fn.readfile(data_file_path)
	data = table.concat(data, "\n")
	return vim.fn.json_decode(data)
end

local data = get_data_file()

local function write_data_file(obj)
	for key, value in pairs(obj) do
		data[key] = value
	end

	data = vim.fn.json_encode(data)
	local lines = vim.split(data, "\n")
	vim.fn.writefile(lines, data_file_path)
end

function DataBase.refresh_data()
	data = get_data_file()
	return data
end

function DataBase.health_check()
	local zonkan_data_path = data_file_path .. "/" .. "zonkan"
	if not exists(zonkan_data_path) then
		vim.fn.mkdir(zonkan_data_path, "p")
	end
	local zonkan_data_file = zonkan_data_path .. "/" .. "data.json"
	if not exists(zonkan_data_file) then
		vim.fn.writefile({}, zonkan_data_file)
	end
	DataBase.refresh_data()
end

function DataBase.add_project(name, directory, tags)
	if data[name] then
		return error("Project Already Exists")
	end

	local project_data = {
		[name] = {
			tags = tags,
			project_dir = directory,
		},
	}

	write_data_file(project_data)
	DataBase.refresh_data()
end

function DataBase.get_project(name)
	return data[name]
end

function DataBase.search_projects(query)
	-- Query is a table of like below
	-- {name=x, tags=[x,x,x], project_dir=x}
	-- and function returns list of searches and distances
	return FuzzySearch(data, query, 3)
end

return DataBase
