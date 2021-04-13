--Script made by kqpi
ESX = nil

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }
local PlayerData				= {}
local zaczete = false
local needpielegniarka = false
local rekawiczki = false
local ustawienia = false
local operowanie = false
local papierek = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if not kqpi1 then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            for i,v in pairs(Config.StartPracy) do
                if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 10 then
                    DrawMarker(27, v.x, v.y, v.z -0.95, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
                    if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2) then
                        ESX.ShowHelpNotification('Naciśnij ~INPUT_PICKUP~, aby zacząć lokalną prace ' ..Config.NazwaFrakcji)
                        if IsControlPressed(1, 51) and not kqpi1 then
                            OpenRozpoczynanieMenu()
                        end
                    end
                end
            end
        else
            Citizen.Wait(2000)
        end
    end
end)

RegisterNetEvent("k_pracaems:SalaOperacyjna")
AddEventHandler("k_pracaems:SalaOperacyjna", function()
    while true do
        Citizen.Wait(1)
        if ustawienia == false then
            if zaczete == true then
                local coords = GetEntityCoords(GetPlayerPed(-1))
                for i,v in pairs(Config.SalaOperacyjna) do
                    if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 10 then
                        DrawMarker(27, v.x, v.y, v.z -0.95, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
                        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2) then
                            ESX.ShowHelpNotification('Naciśnij ~INPUT_PICKUP~, aby rozpocząć operację')
                            if IsControlPressed(1, 51) and not kqpi1 then
                                OpenPracaMenu()
                            end
                        end
                    end
                end
            else
                Citizen.Wait(2000)
            end
        end
    end
end)

RegisterNetEvent("k_pracaems:Anulowanie")
AddEventHandler("k_pracaems:Anulowanie", function()
    while true do
        Citizen.Wait(1)
        if zaczete == true then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            for i,v in pairs(Config.AnulowaniePracy) do
                if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 10 then
                    DrawMarker(27, v.x, v.y, v.z -0.95, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
                    if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2) then
                        ESX.ShowHelpNotification('Naciśnij ~INPUT_PICKUP~, aby anulować prace')
                        if IsControlPressed(1, 51) and zaczete == true then
                            OpenAnulowanie()
                        end
                    end
                end
            end
        else
            Citizen.Wait(2000)
        end
    end
end)

function OpenAnulowanie()
  
    local elements = {
        {label = 'Czy chcesz anulować lokalną pracę?',     value = 'pytanie'},
        {label = '====================================',     value = 'pytanie'},
        {label = 'Tak',     value = 'tak'},
        {label = 'Nie',     value = 'nie'},

        }
    
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'anulowanie',
      {
        title    = 'Praca ' ..Config.NazwaFrakcji,
        align    = 'center',
        elements = elements
        },
            function(data2, menu2)
                if data2.current.value == 'tak' then
                    zaczete = false
                    ustawienia = false
                    operowanie = false
                    papierek = false
                    ESX.UI.Menu.CloseAll()
                elseif data2.current.value == 'nie' then
                    ustawienia = false
                    ESX.UI.Menu.CloseAll()
                end
  
            end,
            function(data, menu)
            menu.close()
          end)
    end 

function OpenRozpoczynanieMenu()
  
    local elements = {
        {label = 'Czy Napewno chcesz zacząć lokalną pracę?',     value = 'pytanie'},
        {label = '===========================================',     value = 'pytanie'},
        {label = 'Tak',     value = 'tak'},
        {label = 'Nie',     value = 'nie'},

        }
    
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'potwierdzenie',
      {
        title    = 'Praca ' ..Config.NazwaFrakcji,
        align    = 'center',
        elements = elements
        },
            function(data2, menu2)
                if data2.current.value == 'tak' then
                    if zaczete == false then
                        if PlayerData.job.name == Config.NazwaPracy then
                            zaczete = true
                            TriggerEvent("pNotify:SendNotification", { text = "No to zaczynamy!", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                            TriggerEvent("pNotify:SendNotification", { text = "Udaj się do Sali Operacyjnej", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                            TriggerEvent("k_pracaems:SalaOperacyjna")
                            TriggerEvent("k_pracaems:Anulowanie")
                        else
                            TriggerEvent("pNotify:SendNotification", { text = "Nie należysz do Frakcji "..Config.NazwaFrakcji, type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                        end
                        ESX.UI.Menu.CloseAll()
                    elseif zaczete == true then
                        TriggerEvent("pNotify:SendNotification", { text = "Wykonujesz już tą prace", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                    end
                elseif data2.current.value == 'nie' then
                    ESX.UI.Menu.CloseAll()
                    TriggerEvent("pNotify:SendNotification", { text = "Szkoda... Pacjentami zajmie się ktoś inny", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                end
  
            end,
            function(data, menu)
            menu.close()
          end)
    end 


function OpenPracaMenu()
  
    local elements = {
        {label = 'No to Zaczynamy!',     value = 'pytanie'},
        {label = 'Pierwsi pacjenci już czekają',     value = 'pytanie'},
        {label = 'Ale nim zaczniesz, musisz podjąć kilka ważnych decyzji',     value = 'pytanie'},
        {label = '===========================================',     value = 'pytanie'},
        {label = 'Dalej',     value = 'dalej'},

        }
        
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'praca',
      {
        title    = 'Praca ' ..Config.NazwaFrakcji,
        align    = 'center',
        elements = elements
        },
            function(data2, menu2)
                if data2.current.value == 'dalej' then
                    OpenPracaMenu2()
                end
    
            end,
            function(data, menu)
            menu.close()
          end)
    end 

function OpenPracaMenu2()
  
    local elements = {
        {label = 'Czy potrzebujesz asysty Pielęgniarki?',     value = 'pytanie'},
        {label = '=======================================',     value = 'pytanie'},
        {label = 'Tak',     value = 'tak'},
        {label = 'Nie',     value = 'nie'},

        }
        
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'praca',
      {
        title    = 'Praca ' ..Config.NazwaFrakcji,
        align    = 'center',
        elements = elements
        },
            function(data2, menu2)
                if data2.current.value == 'tak' then
                    needpielegniarka = true
                    ESX.UI.Menu.CloseAll()
                    OpenPracaMenu3()
                elseif data2.current.value == 'nie' then
                    needpielegniarka = false
                    ESX.UI.Menu.CloseAll()
                    OpenPracaMenu3()
                end
    
            end,
            function(data, menu)
            menu.close()
          end)
    end 

function OpenPracaMenu3()
  
    local elements = {
        {label = 'Czy chcesz założyć rękawiczki jednorazowe?',     value = 'pytanie'},
        {label = '=======================================',     value = 'pytanie'},
        {label = 'Tak',     value = 'tak'},
        {label = 'Nie',     value = 'nie'},

        }
        
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'praca',
      {
        title    = 'Praca ' ..Config.NazwaFrakcji,
        align    = 'center',
        elements = elements
        },
            function(data2, menu2)
                if data2.current.value == 'tak' then
                    rekawiczki = true
                    ESX.UI.Menu.CloseAll()
                    operowanie = true
                    TriggerEvent("k_pracaems:markeroperacji")
                    ustawienia = true
                elseif data2.current.value == 'nie' then
                    rekawiczki = false
                    ESX.UI.Menu.CloseAll()
                    operowanie = true
                    TriggerEvent("k_pracaems:markeroperacji")
                    ustawienia = true
                end
    
            end,
            function(data, menu)
            menu.close()
          end)
    end 

function StartOperacja()
  
    local elements = {
        {label = 'Zacznij Operowanie',     value = 'operacja'},

        }
        
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'praca',
      {
        title    = 'Praca ' ..Config.NazwaFrakcji,
        align    = 'center',
        elements = elements
        },
            function(data2, menu2)
                if data2.current.value == 'operacja' then
                    if needpielegniarka == false then
                        TriggerEvent("pNotify:SendNotification", { text = "Zacząłeś operacje! Przez brak pięlęgniarki zajmie to dłużej", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                        TriggerEvent("pNotify:SendNotification", { text = "Kliknij DELETE aby anulować!", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                        ESX.UI.Menu.CloseAll()
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "operowanie",
                            duration = Config.CzasOperacji,
                            label = "Operowanie",
                            useWhileDead = false,
                            canCancel = true,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }
                        }, function(status)
                            if not status then
                                TriggerEvent("pNotify:SendNotification", { text = "Nieźle, dobrze przeprowadzona operacja!", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                                TriggerEvent("pNotify:SendNotification", { text = "Teraz już tylko wystarczy uzupełnić papierkową robotę", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                                operowanie = false
                                papierek = true
                            end
                        end)
                    end
                    if needpielegniarka == true then
                        TriggerEvent("pNotify:SendNotification", { text = "Zacząłeś operacje! Dzięki pielęgniarce pójdzie szybciej", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                        TriggerEvent("pNotify:SendNotification", { text = "Kliknij DELETE aby anulować!", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                        ESX.UI.Menu.CloseAll()
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "operowanie",
                            duration = Config.CzasOperacjiPielegniarka,
                            label = "Operowanie",
                            useWhileDead = false,
                            canCancel = true,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }
                        }, function(status)
                            if not status then
                                TriggerEvent("pNotify:SendNotification", { text = "Nieźle, dobrze przeprowadzona operacja!", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                                TriggerEvent("pNotify:SendNotification", { text = "Teraz już tylko wystarczy uzupełnić papierkową robotę, pójdz do biura", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                                operowanie = false
                                papierek = true
                                TriggerEvent("k_pracaems:papierki")
                            end
                        end)
                    end
                end
            end,
            function(data, menu)
            menu.close()
          end)
    end 


function Papierki()
  
    local elements = {
        {label = 'Zacznij Pracę Papierkową',     value = 'papierki'},

        }
        
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'praca',
      {
        title    = 'Praca ' ..Config.NazwaFrakcji,
        align    = 'center',
        elements = elements
        },
            function(data2, menu2)
                if data2.current.value == 'papierki' then
                    if needpielegniarka == true then
                        TriggerEvent("pNotify:SendNotification", { text = "Zacząłeś wypełniać papierki", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                        TriggerEvent("pNotify:SendNotification", { text = "Kliknij DELETE aby anulować!", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                        ESX.UI.Menu.CloseAll()
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "operowanie",
                            duration = Config.CzasWypelniania,
                            label = "Wypełnianie papierów",
                            useWhileDead = false,
                            canCancel = true,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }
                        }, function(status)
                            if not status then
                                TriggerEvent("pNotify:SendNotification", { text = "Zarobiłeś: " ..Config.IleSianaPielegniarka..  "$" , type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                                TriggerEvent("pNotify:SendNotification", { text = "Jako, że poprosiłeś pielęgniarke o pomoc, dostałeś trochę mniej" , type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                                TriggerServerEvent("k_pracaems:sianodajpielegniarka")
                                zaczete = false
                                ustawienia = false
                                operowanie = false
                                papierek = false
                            end
                        end)
                    end

                    if needpielegniarka == false then
                        TriggerEvent("pNotify:SendNotification", { text = "Zacząłeś wypełniać papierki", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                        TriggerEvent("pNotify:SendNotification", { text = "Kliknij DELETE aby anulować!", type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                        ESX.UI.Menu.CloseAll()
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "operowanie",
                            duration = Config.CzasWypelniania,
                            label = "Wypełnianie papierów",
                            useWhileDead = false,
                            canCancel = true,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }
                        }, function(status)
                            if not status then
                                TriggerEvent("pNotify:SendNotification", { text = "Zarobiłeś: " ..Config.IleSiana.. "$" , type = "warning", timeout = 8000, layout = "centerRight", queue = "right" })
                                TriggerServerEvent("k_pracaems:sianodaj")
                                zaczete = false
                                ustawienia = false
                                operowanie = false
                                papierek = false
                            end
                        end)
                    end
                end
            end,
            function(data, menu)
            menu.close()
          end)
    end 
    

RegisterNetEvent("k_pracaems:markeroperacji")
AddEventHandler("k_pracaems:markeroperacji", function()
    while true do
        Citizen.Wait(1)
        if operowanie == true then 
            if zaczete == true then
                local coords = GetEntityCoords(GetPlayerPed(-1))
                for i,v in pairs(Config.StartOperacji) do
                    if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 10 then
                        DrawMarker(27, v.x, v.y, v.z -0.95, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
                        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2) then
                            ESX.ShowHelpNotification('Naciśnij ~INPUT_PICKUP~, aby rozpocząć operowanie')
                            if IsControlPressed(1, 51) and not kqpi1 then
                                StartOperacja()
                            end
                        end
                    end
                end
            else
                Citizen.Wait(2000)
            end
        end
    end
end)

RegisterNetEvent("k_pracaems:papierki")
AddEventHandler("k_pracaems:papierki", function()
    while true do
        Citizen.Wait(1)
        if papierek == true then 
            if zaczete == true then
                local coords = GetEntityCoords(GetPlayerPed(-1))
                for i,v in pairs(Config.MiejscePapierka) do
                    if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 10 then
                        DrawMarker(27, v.x, v.y, v.z -0.95, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 0, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
                        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2) then
                            ESX.ShowHelpNotification('Naciśnij ~INPUT_PICKUP~, aby rozpocząć papierkową robote')
                            if IsControlPressed(1, 51) and not kqpi1 then
                                Papierki()
                            end
                        end
                    end
                end
            else
                Citizen.Wait(2000)
            end
        end
    end
end)

--Script made by kqpi