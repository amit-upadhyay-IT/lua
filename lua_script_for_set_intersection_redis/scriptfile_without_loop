local noOfArgs = KEYS[1]

local interSet = redis.call("sinter", unpack(ARGV))

local allString = ""

for _,key in ipairs(interSet) do
	local val = redis.call("HGET", key, "name")
	allString = val..', '..allString
end

return allString
