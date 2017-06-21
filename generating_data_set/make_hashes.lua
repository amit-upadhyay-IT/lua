for i = 1, 1000000, 1 do
    redis.call('hmset', 'meeting:'..i, 'details', 'details for meeting '..i, 'clientid', i%5000, 'score', math.random(1000))
end
