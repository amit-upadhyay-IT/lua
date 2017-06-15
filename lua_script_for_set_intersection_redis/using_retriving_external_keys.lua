local noOfArgs = KEYS[1] -- storing the number of arguments that will get passed from cli

local interSet = redis.call("sinterstore", "sampleset1",  unpack(ARGV))

local val2 = redis.call("sort", "sampleset1", "get", "playerid:*->name")

return val2
