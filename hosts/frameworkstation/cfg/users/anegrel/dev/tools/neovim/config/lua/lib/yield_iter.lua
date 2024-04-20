local M = {}

if table.unpack == nil then
	---@diagnostic disable-next-line: deprecated
	table.unpack = unpack
end

M.new = function(fn)
	local co = coroutine.create(function()
		fn(coroutine.yield)
	end)

	return function()
		local results = { coroutine.resume(co) }
		if not results[1] then
			if #results == 1 then
				return nil
			else
				error(results[2])
			end
		end

		return table.unpack(results, 2)
	end
end

return M
