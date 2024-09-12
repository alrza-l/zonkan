local function levenshtein(s, t)
	local d = {}
	local len_s = #s
	local len_t = #t

	for i = 0, len_s do
		d[i] = {}
		d[i][0] = i
	end

	for j = 0, len_t do
		d[0][j] = j
	end

	for i = 1, len_s do
		for j = 1, len_t do
			local cost = (s:sub(i, i) == t:sub(j, j)) and 0 or 1
			d[i][j] = math.min(d[i - 1][j] + 1, d[i][j - 1] + 1, d[i - 1][j - 1] + cost)
		end
	end

	return d[len_s][len_t]
end

local function append_results(results, distance, key, cquery_type, max_distance)
	if distance<=max_distance then
		table.insert(results, {key={distance=distance, query_type=cquery_type}
	end
end
function FuzzySearch(tbl, search_terms, max_distance)
	local results = {}

	local name_q = search_terms["name"]
	local tags_q = search_terms["tags"]
	local dir_q = search_terms["project_dir"]

	for key, value in pairs(tbl) do
		if name_q then
			local distance = levenshtein(key, name_q)
			append_results(results, distance, key, "name", max_distance)
		end

		if tags_q then
			for tag in value["tags"] do
				local distance = levenshtein(tag, tags_q)
				append_results(results, distance, key, "tags", max_distance)
			end
		end

		if dir_q then
			local distance = levenshtein(value["project_dir"], tags_q)
			append_results(results, distance, key, "project_dir", max_distance)
		end
	end

	table.sort(results, function(a, b)
		return a.distance < b.distance
	end)

	return results
end

