local registeredCallbacks = {}

function RegisterServerCallback(name, cb)
    registeredCallbacks[name] = cb
end

RegisterNetEvent(eventReq, function(name, requestId, ...)
    local src = source
    local cb = registeredCallbacks[name]
    if cb then
        local result = { cb(src, ...) }
        
        TriggerClientEvent(eventRes, src, requestId, table.unpack(result))
    end
end)