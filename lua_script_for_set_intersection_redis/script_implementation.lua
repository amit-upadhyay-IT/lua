-- commit started from 19th.

--[[
1) get user_id; (from keys[1])
2) get meeting filtered set;
3) get client_for_user:x set;
4) iterate through meeting filtered set and get client id of that particular meeting from hashmap.
	4.1) check if that client id is member of set "client_for_user:x"
	4.2) store that meeting_id into a set, so that later we can perform sorting on that set.
--]]

local user_id = KEYS[1] --  get user_id;

local meeting_filter_set = redis.call("sinterstore", "sampleset1"..user_id,  unpack(ARGV)) -- meeting filtered set.
local mfs = redis.call("sinter", unpack(ARGV)) -- meeting filtered set.

local clients_for_user_set_name = 'clients_for_user:'..user_id

local members_of_clients = redis.call("smembers", clients_for_user_set_name) -- client_for_user:x

-- iterating through meeting filtered set
for _,key in ipairs(mfs) do
	local obtained_client_ids = redis.call("HGET", 'meeting:'..key, "clientid")
	-- check if clientid obtained is contained in "members_of_clients"
	local val = redis.call("sismember", clients_for_user_set_name, obtained_client_ids)
	-- check if val is 0 or 1. If val == 1, store meeting:id into a set (or if val == 0, delete meetingid from the meeting_filtered_set)
	if val == 1 then
		redis.call("sadd", "sampleset2"..user_id, key)
	end
end

--local val2 = redis.call("sort", "sampleset1", "get", "meeting:*->clientid")

-- get the members from set named "sampleset1"..user_id
local security_level_filter = redis.call("smembers", "sampleset2"..user_id)

return security_level_filter
