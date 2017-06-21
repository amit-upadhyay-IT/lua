-- generating clients_for_user:* sets
-- we shall create 100000 of sets

for i = 1, 100000, 1 do
    local set_name = 'clients_for_user:'..i

    for j = 1, 100000, 1 do -- this will put about 100000 members
        redis.call('sadd', set_name, math.random(1000000))
    end

end

--[[
    from the loop we can say that there can be upto 10 lac
    of clients. However the user will have access to less than 100000
    clients.

    we are creating 1 lac sets for clients_for_user:x
--]]
