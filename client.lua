
--[[
    Lavet af: ReanCoding
--]]

------------------------------------------------ Scriptet -----------------------------------------------------------------
------------------------------------------------ Du må ikke ændre noget her -----------------------------------------------------------------
local ReanCoding = {
    ['penge'] = "penge",
    ['fyr'] = "fyr"
}

RegisterNetEvent("Emotes:ReanCoding")
function displayEmotes()
    local index = 0
    local display = "^7"

    for name, value in pairs(ReanCoding) do
        index = index + 1
        if index == 1 then
            display = display..name
        else
            display = display..", "..name
        end
    end

    TriggerEvent("chatMessage", "EMOTES", {255,0,0}, "")
    TriggerEvent("chatMessage", "", {255,255,255}, "penge - fyr")
end

AddEventHandler("Emotes:ReanCoding", function()
    displayEmotes()
end)
