--[[

--]]

local noOfArgs = KEYS[1] -- storing the number of arguments that will get passed from cli

local varOne = ARGV[1]
local varTwo = ARGV[1]

local setNameOne = 'points:'..varOne -- first set
local setNameTwo = 'points:'..varTwo -- second set

local allString = ""

local name=redis.call("sinter", setNameOne, setNameTwo, ARGV[2])


for _,key in ipairs(name) do
	local val = redis.call("HGET", key, "name")
	io.write(val)
	allString = val..', '..allString
end

--return allString
return KEYS.length