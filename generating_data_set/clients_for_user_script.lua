-- generating clients_for_user:* sets
-- we shall create 10 of sets

for i = 1, 10, 1 do
    local set_name = 'clients_for_user:'..i

    for j = 1, 5000, 1 do -- this will put about 10000 members
        redis.call('sadd', set_name, j) -- so clients ids can range up 1 lac
    end

end

--[[
    from the loop we can say that there can be upto 10 lac
    of clients. However the user will have access to less than 100000
    clients.

    we are creating 1 lac sets for clients_for_user:x
--]]
