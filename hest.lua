--[[
    Lavet af: ReanCoding
--]]
------------------------------------------------ Props -----------------------------------------------------------------
local holdinghors = false
local horsmodel = “ba_prop_battle_hobby_horse”
local hors_net = nil
------------------------------------------------ Scriptet -----------------------------------------------------------------
RegisterCommand("hest",function(source, args)
	local ad1 = "anim@amb@nightclub@lazlow@hi_dancefloor@"
	local ad1a = "dancecrowd_li_15_handup_laz"
	local player = GetPlayerPed(-1)
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local umbspawned = CreateObject(GetHashKey(horsmodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	local netid = ObjToNet(umbspawned)


	if (DoesEntityExist(player) and not IsEntityDead(player)) then 
		loadAnimDict(ad1)
		RequestModel(GetHashKey(horsmodel))
		if holdinghors then
			Wait(100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			DetachEntity(NetToObj(hors_net), 1, 1)
			DeleteEntity(NetToObj(hors_net))
			hors_net = nil
			holdinghors = false
		else		
			PlayFacialAnim( player, "mood_dancing_medium_1", "facials@gen_male@base")
			TaskPlayAnim(player, ad1, ad1a, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			Wait(500)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			AttachEntityToEntity(umbspawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.0,0.0,0.0,0.0,0.0,0.0,1,1,0,1,0,1)
			Wait(120)
			hors_net = netid
			holdinghors = true
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

