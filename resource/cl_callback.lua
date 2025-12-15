local pendingCallbacks = {}

function TriggerServerCallback(name, ...)
    local p = promise.new()
    local requestId = GetGameTimer() .. math.random(1, 999999)
    pendingCallbacks[requestId] = p
    TriggerServerEvent(eventReq, name, requestId, ...)
    return Citizen.Await(p)
end

RegisterNetEvent(eventRes, function(requestId, ...)
    local p = pendingCallbacks[requestId]
    if p then
        p:resolve(...)
        pendingCallbacks[requestId] = nil
    end
end)