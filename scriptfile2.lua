local varOne = KEYS[1]
local varTwo = ARGV[1]

local setName = 'points:'..varOne

--[[

--]]

local allString = ""

local name=redis.call("smembers", setName)


for _,key in ipairs(name) do
	local val = redis.call("HGET", key, "name")
	--io.write(val)
	allString = val..', '..allString
end

--[[
local hashData = redis.call("HGETALL", name)
--]]

return allString
