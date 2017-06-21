-- generating meeting_type:email, meeting_type:sms, meeting_status:open
-- meeting_status:close sets

local meeting_typeemail_set

for i = 1, 1000, 1 do
    redis.call("sadd", "meeting_type:email", math.random(i, 10000))
end

for i = 1, 1000, 1 do
    redis.call("sadd", "meeting_type:sms", math.random(i, 10000))
end

for i = 1, 1000, 1 do
    redis.call("sadd", "meeting_status:open", math.random(i, 10000))
end

for i = 1, 1000, 1 do
    redis.call("sadd", "meeting_status:close", math.random(i, 10000))
end
