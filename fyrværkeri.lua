--[[
    Lavet af: ReanCoding
--]]
------------------------------------------------ Props -----------------------------------------------------------------
local holdingfw = false
local fyrvarkeri = "ind_prop_firework_01"
local fw_net = nil
------------------------------------------------ Scriptet -----------------------------------------------------------------
RegisterCommand("fyr",function(source, args)
	local player = GetPlayerPed(-1)
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local fyrvarkeri = CreateObject(GetHashKey(fyrvarkeri), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	local netid = ObjToNet(fyrvarkeri)
	local ad = "anim@amb@nightclub@mini@drinking@champagne_drinking@base@"
	local pd = "scr_indep_fireworks" 
	local pn = "scr_indep_firework_fountain"

	if (DoesEntityExist(player) and not IsEntityDead(player)) then
		loadAnimDict(ad)
		RequestModel(GetHashKey(fyrvarkeri))
		if holdingfw then
			TaskPlayAnim(player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			Wait(1840)
			DetachEntity(NetToObj(fw_net), 1, 1)
			DeleteEntity(NetToObj(fw_net))
			Wait(750)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			fw_net = nil
			holdingfw = false
			RemoveNamedPtfxAsset(pd)
			RemoveAnimDict(ad)
		else
			Wait(500)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			TaskPlayAnim( player, ad, "bottle_hold_idle", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
			Wait (1260)
			AttachEntityToEntity(fyrvarkeri,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
			TriggerEvent("pNotify:SendNotification",{text = "Tryk [E] for at starte fyrværket",type = "info",timeout = (5000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			fw_net = netid
			holdingfw = true
		end
	end
	while holdingfw do
		Wait(0)
		if IsControlJustPressed(0, 38) then
			Notification("Det her er sgu sjovt!")
			Wait(500)
			RequestNamedPtfxAsset(pd)
			HasNamedPtfxAssetLoaded(pd)
			UseParticleFxAssetNextCall(pd)
			StartParticleFxLoopedOnEntity(pn, fyrvarkeri, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, false, false, false)
		end
	end
end, false)
------------------------------------------------ Du må ikke ændre noget her -----------------------------------------------------------------
function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do 
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end
