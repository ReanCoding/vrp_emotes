--[[
    Lavet af: ReanCoding
--]]
------------------------------------------------ Du må KUN ændre "/emotes" commanden her -----------------------------------------------------------------
AddEventHandler('chatMessage', function(source, n, msg)
    local args = stringsplit(msg, ' ')

    if string.lower(args[1]) == "/emotes" then
        TriggerClientEvent("Emotes:ReanCoding", source)
        CancelEvent()
    end
    end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
