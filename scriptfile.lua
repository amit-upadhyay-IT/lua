local varOne = KEYS[1]
local varTwo = ARGV[1]

local setName = 'points:'..varOne

--[[

--]]

local name=redis.call("srandmember", setName)

local hashData = redis.call("HGETALL", name)

return hashData
