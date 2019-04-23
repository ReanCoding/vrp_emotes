--[[
    Lavet af: ReanCoding
--]]



------------------------------------------------ Props -----------------------------------------------------------------

local holdingpenge = false
local pengemodel = "prop_anim_cash_pile_01"
local cash_net = nil

------------------------------------------------ Scriptet -----------------------------------------------------------------

RegisterCommand("penge",function(source, args)

	local player = GetPlayerPed(-1)
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local pengemodel = CreateObject(GetHashKey(pengemodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	local netid = ObjToNet(pengemodel)
	local ad = "anim@mp_player_intupperraining_cash"
	local pd = "scr_xs_celebration" 
	local pn = "scr_xs_money_rain"

	if (DoesEntityExist(player) and not IsEntityDead(player)) then
		loadAnimDict(ad)
		RequestPtfxAsset(pd)
		RequestModel(GetHashKey(pengemodel))
		if holdingpenge then
			DetachEntity(NetToObj(cash_net), 1, 1)
			DeleteEntity(NetToObj(cash_net))
			Wait(750)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			cash_net = nil
			holdingpenge = false
			StopParticleFxLooped(pn,0)
		else
			Wait(500)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 51, 0, 0, 0, 0 )
			Wait(1260)
			AttachEntityToEntity(pengemodel,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309),0.0,0.0,0.01,180.0,360.0,70.0,1,1,0,1,0,1)
         TriggerEvent("pNotify:SendNotification",{text = "Tryk [E] for at kaste med penge",type = "info",timeout = (5000),layout = "centerLeft",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
			cash_net = netid
			holdingpenge = true
		end
	end

	while holdingpenge do
		Wait(0)
		if IsControlJustPressed(0, 38) then
			Wait(500)
			RequestNamedPtfxAsset(pd)
			HasNamedPtfxAssetLoaded(pd)
			UseParticleFxAssetNextCall(pd)
			StartParticleFxLoopedOnEntity(pn, pengemodel, 0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0, false, false, false)
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
