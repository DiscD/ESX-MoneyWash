ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('lt:CheckAboutDirty')
AddEventHandler('lt:CheckAboutDirty', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local black = xPlayer.getAccount('black_money').money

end)


RegisterServerEvent('lt:ui')
AddEventHandler('lt:ui', function(amount)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local black = xPlayer.getAccount('black_money').money
    if black > 0 then
        xPlayer.addMoney(amount)
        xPlayer.removeAccountMoney('black_money', amount)
    else
            TriggerClientEvent("notification", xPlayer.source, "You do not have enough money.", 2)
    end
end)

RegisterServerEvent("lt:CopCount")
AddEventHandler("lt:CopCount", function()
    local copcount  = 0
    local Players = ESX.GetPlayers()

    for i = 1, #Players, 1 do
        local xPlayer = ESX.GetPlayerFromId(Players[i])

        if xPlayer.job.name == "police" then
            copcount = copcount + 1
        end
    end
    local xPlayer = ESX.GetPlayerFromId(_source)
    if copcount < Config.CopsRequired then
        TriggerEvent("notification", "Not enough cops.", 2)
    else
    end
end)








