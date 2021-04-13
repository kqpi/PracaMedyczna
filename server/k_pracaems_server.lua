--Script made by kqpi
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('k_pracaems:sianodaj')
AddEventHandler('k_pracaems:sianodaj', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addMoney(Config.IleSiana)
end)

RegisterServerEvent('k_pracaems:sianodajpielegniarka')
AddEventHandler('k_pracaems:sianodajpielegniarka', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addMoney(Config.IleSianaPielegniarka)
end)

--Script made by kqpi