
local noOfArgs = KEYS[1] -- storing the number of arguments that will get passed from cli

--[[
	run a loop noOfArgs time and initialize table elements, since we don't know the number of sets to be intersected so we will use Table (arrays)
--]]

local setsTable = {}

-- coppies all the set names in setsTable
-- for i = 0, noOfArgs, 1 do
-- 	setsTable[i] = 'points:'..ARGV[i]
-- end

for i = 1, noOfArgs, 1 do
	setsTable[i] = tostring(ARGV[i])
end


-- now find intersection
local intersectedVal = redis.call("sinter", setsTable[1], setsTable[2]) -- finding first intersection because atleast we will have two sets

for i = 3, noOfArgs, 1 do
	intersectedVal = redis.call("sinter", intersectedVal, setsTable[i])
end

local allString = ""

-- now val contains all intersected value

for _,key in ipairs(intersectedVal) do
	local val = redis.call("HGET", key, "name")
	--io.write(val)
	allString = val..', '..allString
end

return allString
