ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


-- Prind 3D Text
function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Wash Money
Citizen.CreateThread(function()
	local coords = GetEntityCoords(ped)
	local playerPeda = PlayerPedId()
	while true do
		Citizen.Wait(4)
		if isNear then
			DrawText3Ds(Config.WashMoney.x, Config.WashMoney.y, Config.WashMoney.z+0.3, "~r~E~w~  to wash your money.")
			DrawMarker(2, Config.WashMoney.x, Config.WashMoney.y, Config.WashMoney.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 155, 22, 22, 155, 0, 0, 0, 1, 0, 0, 0)
				if Vdist(coords) and IsControlJustPressed(1, 38) then
					TriggerServerEvent("lt:CopCount")
					TriggerEvent("lt:side")
				end
				
		end
	end
end)


RegisterNetEvent("lt:side")
AddEventHandler("lt:side", function(amount)

	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'WashDirtyMoneya', {
		title = 'Wash Dirty Money',
		align    = 'top-left'
	}, function(data, menu)

		local amount = tonumber(data.value)

		if amount == nil then
			--ESX.ShowNotification('Invalid amound.')
			TriggerEvent("notification", "Invalid amount", 1)
		else
			ESX.UI.Menu.CloseAll()
			local playerPeda = PlayerPedId()
			FreezeEntityPosition(playerPeda, true)
			local dict = "missheist_jewel@hacking"
			RequestAnimDict(dict)
			TaskPlayAnim(playerPeda, dict, "hack_loop", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
			local finished = exports["np-taskbar"]:taskBar(Config.WaitTime,"Connecting hacking Laptop")
			FreezeEntityPosition(playerPeda, false)
			TriggerServerEvent("lt:ui", amount)
			
		end

	end, function(data, menu)
		ESX.UI.Menu.CloseAll()
	end)

end)

local blips = {
	{title="Money Wash", colour=26, id=290, x = Config.WashMoney.x, y = Config.WashMoney.y, z = Config.WashMoney.z}
}

Citizen.CreateThread(function()
	if Config.ShowBlip then
   for _, info in pairs(blips) do
	 info.blip = AddBlipForCoord(info.x, info.y, info.z)
	 SetBlipSprite(info.blip, 500)
	 SetBlipDisplay(info.blip, 4)
	 SetBlipScale(info.blip, 0.7)
	 SetBlipColour(info.blip, 75)
	 SetBlipAsShortRange(info.blip, true)
	 BeginTextCommandSetBlipName("STRING")
	 AddTextComponentString(info.title)
	 EndTextCommandSetBlipName(info.blip)
   end
end
end)


Citizen.CreateThread(function()
	local ped = PlayerPedId()
	while true do
		local coords = GetEntityCoords(ped)
		Citizen.Wait(500)
		if Vdist(coords, Config.WashMoney) < 5 then
			isNear = true
		else
			isNear = false
		end
	end
end)