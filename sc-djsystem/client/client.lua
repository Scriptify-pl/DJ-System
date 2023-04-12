local nearestDJName = ""

local function openPanelDJ()
    local input = lib.inputDialog('DJ Panel', {
    _U('dj_text_1'), 
    _U('dj_text_2'), 
    _U('dj_text_3')
    })

    if not input then 
        return ESX.ShowNotification(_U('dj_notify_1'))
    end

    local input_one = input[1]
    local input_two = input[2]
    local input_three = input[3]
    ESX.TriggerServerCallback('scriptify_executeDJmenu', function(cb)
    end, input_one, input_two, input_three)
end

local function CheckNearbyDJ()
    local minDistance = math.huge
    local plyCoords = GetEntityCoords(PlayerPedId(), 0)
        for _, dj in pairs(Config.DJpanels) do
            for i = 1, #dj.coords, 1 do
            local djDistance = #(vector3(dj.coords[i].x, dj.coords[i].y, dj.coords[i].z) - plyCoords)
            
            if djDistance < minDistance then
                minDistance = djDistance
                nearestDJName = dj.dj_name
            end
        end
    end
end

local function destoryMusic()
    ESX.TriggerServerCallback('scriptify_destoryMusic', function(cb)
    end)
end

RegisterNetEvent('scriptify_play_music', function(input_one, input_two, input_three, tokenizer)
    local plyCoords = GetEntityCoords(PlayerPedId(), 0)
    if tokenizer == Config.TokenizerToken then
            if input_three == nil then
                ESX.ShowNotification(_U('dj_notify_2'))
            else
            local xSound = exports["xsound"]
            CheckNearbyDJ()
            Wait(100)
            destoryMusic()
            Wait(500)
            xSound:PlayUrlPos(nearestDJName, input_one, input_two, vector3(plyCoords), false)
            xSound:Distance(nearestDJName, input_three)
        end
        else
        ESX.ShowNotification(_U('dj_notify_3'))
    end
end)

RegisterNetEvent('scriptify_destoryMusic', function(tokenizer)
        if tokenizer == Config.TokenizerToken then
            local xSound = exports["xsound"]
            local minDistance = math.huge
            local plyCoords = GetEntityCoords(PlayerPedId(), 0)
            
            for _, dj in pairs(Config.DJpanels) do
                for i = 1, #dj.coords, 1 do
                    local djDistance = #(vector3(dj.coords[i].x, dj.coords[i].y, dj.coords[i].z) - plyCoords)
                    
                if djDistance < minDistance then
                    minDistance = djDistance
                    nearestDJName = dj.dj_name
                end
            end
        end
        xSound:Destroy(nearestDJName)
    end
end)

Citizen.CreateThread(function()
    local repeter
    repeat
        Citizen.Wait(5)
            for k,v in pairs(Config.DJpanels) do
                for i = 1, #v.coords, 1 do
                    local plyCoords = GetEntityCoords(PlayerPedId(), 0)
                    local distance = #(vector3(v.coords[i].x, v.coords[i].y, v.coords[i].z) - plyCoords)
            if distance < 5 then
                if IsControlJustReleased(0, 46) then
                    openPanelDJ()
                end
            end
            if distance < 5 and not v.isInZone then
                lib.showTextUI(_U('dj_showTextUI'))
                v.isInZone = true
            elseif distance > 5 and v.isInZone then
                v.isInZone = false
                lib.hideTextUI()
                end
            end
        end
    until(repeter)
end)