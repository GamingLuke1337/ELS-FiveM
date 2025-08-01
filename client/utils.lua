RegisterNetEvent("els:updateElsVehicles")
AddEventHandler("els:updateElsVehicles", function(vehicles, patterns)
    els_Vehicles = vehicles
    els_patterns = patterns

    lightPatternPrim = 1
    lightPatternSec = 1
    advisorPatternSelectedIndex = 1
end)

RegisterNetEvent("els:changeLightStage_c")
AddEventHandler("els:changeLightStage_c", function(sender, stage, advisor, prim, sec)
    CreateThread(function()

        local player_s = GetPlayerFromServerId(sender)
        local ped_s = GetPlayerPed(player_s)
        if player_s ~= -1 then
            if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
                if IsPedInAnyVehicle(ped_s, false) then

                    local vehNetID = GetVehiclePedIsUsing(ped_s)

                    if elsVehs[vehNetID] ~= nil then
                        elsVehs[vehNetID].stage = stage
                        if (stage == 1) then
                            elsVehs[vehNetID].warning = false
                            elsVehs[vehNetID].secondary = true
                            elsVehs[vehNetID].primary = false
                        elseif (stage == 2) then
                            elsVehs[vehNetID].warning = false
                            elsVehs[vehNetID].secondary = true
                            elsVehs[vehNetID].primary = true
                        elseif (stage == 3) then
                            elsVehs[vehNetID].warning = true
                            elsVehs[vehNetID].secondary = true
                            elsVehs[vehNetID].primary = true
                        else
                            elsVehs[vehNetID].warning = false
                            elsVehs[vehNetID].secondary = false
                            elsVehs[vehNetID].primary = false
                        end
                        elsVehs[vehNetID].primPattern = prim
                        elsVehs[vehNetID].secPattern = sec
                        elsVehs[vehNetID].advisorPattern = advisor
                    else
                        elsVehs[vehNetID] = {}
                        elsVehs[vehNetID].stage = stage
                        if (stage == 1) then
                            elsVehs[vehNetID].warning = false
                            elsVehs[vehNetID].secondary = true
                            elsVehs[vehNetID].primary = false
                        elseif (stage == 2) then
                            elsVehs[vehNetID].warning = false
                            elsVehs[vehNetID].secondary = true
                            elsVehs[vehNetID].primary = true
                        elseif (stage == 3) then
                            elsVehs[vehNetID].warning = true
                            elsVehs[vehNetID].secondary = true
                            elsVehs[vehNetID].primary = true
                        else
                            elsVehs[vehNetID].warning = false
                            elsVehs[vehNetID].secondary = false
                            elsVehs[vehNetID].primary = false
                        end
                        elsVehs[vehNetID].primPattern = prim
                        elsVehs[vehNetID].secPattern = sec
                        elsVehs[vehNetID].advisorPattern = advisor
                    end
                end
            end
        end
        return
    end)
end)

RegisterNetEvent("els:changePartState_c")
AddEventHandler("els:changePartState_c", function(sender, part, newstate)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if player_s ~= -1 then
        if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
            if IsPedInAnyVehicle(ped_s, false) then
                local vehNetID = GetVehiclePedIsUsing(ped_s)

                if elsVehs[vehNetID] == nil then
                    elsVehs[vehNetID] = {}
                    elsVehs[vehNetID].stage = 0
                    elsVehs[vehNetID].primPattern = 1
                    elsVehs[vehNetID].secPattern = 1
                    elsVehs[vehNetID].advisorPattern = 1
                end

                elsVehs[vehNetID][part] = newstate
            end
        end
    end
end)

RegisterNetEvent("els:changeAdvisorPattern_c")
AddEventHandler("els:changeAdvisorPattern_c", function(sender, pat)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if player_s ~= -1 then
        if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
            if IsPedInAnyVehicle(ped_s, false) then

                local vehNetID = GetVehiclePedIsUsing(ped_s)

                if elsVehs[vehNetID] == nil then
                    elsVehs[vehNetID] = {}
                    elsVehs[vehNetID].stage = 0
                    elsVehs[vehNetID].primPattern = 1
                    elsVehs[vehNetID].secPattern = 1
                    elsVehs[vehNetID].advisorPattern = 1
                end

                if elsVehs[vehNetID] ~= nil then
                    elsVehs[vehNetID].advisorPattern = pat
                else
                    elsVehs[vehNetID] = {}
                    elsVehs[vehNetID].advisorPattern = pat
                end
            end
        end
    end
end)

RegisterNetEvent("els:changeSecondaryPattern_c")
AddEventHandler("els:changeSecondaryPattern_c", function(sender, pat)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if player_s ~= -1 then
        if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
            if IsPedInAnyVehicle(ped_s, false) then

                local vehNetID = GetVehiclePedIsUsing(ped_s)

                if elsVehs[vehNetID] == nil then
                    elsVehs[vehNetID] = {}
                    elsVehs[vehNetID].stage = 0
                    elsVehs[vehNetID].primPattern = 1
                    elsVehs[vehNetID].secPattern = 1
                    elsVehs[vehNetID].advisorPattern = 1
                end

                if elsVehs[vehNetID] ~= nil then
                    elsVehs[vehNetID].secPattern = pat
                else
                    elsVehs[vehNetID] = {}
                    elsVehs[vehNetID].secPattern = pat
                end
            end
        end
    end
end)

RegisterNetEvent("els:changePrimaryPattern_c")
AddEventHandler("els:changePrimaryPattern_c", function(sender, pat)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if player_s ~= -1 then
        if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
            if IsPedInAnyVehicle(ped_s, false) then

                local vehNetID = GetVehiclePedIsUsing(ped_s)

                if elsVehs[vehNetID] == nil then
                    elsVehs[vehNetID] = {}
                    elsVehs[vehNetID].stage = 0
                    elsVehs[vehNetID].primPattern = 1
                    elsVehs[vehNetID].secPattern = 1
                    elsVehs[vehNetID].advisorPattern = 1
                end

                if elsVehs[vehNetID] ~= nil then
                    elsVehs[vehNetID].primPattern = pat
                else
                    elsVehs[vehNetID] = {}
                    elsVehs[vehNetID].primPattern = pat
                end
            end
        end
    end
end)

RegisterNetEvent("els:setSirenState_c")
AddEventHandler("els:setSirenState_c", function(sender, newstate)
    local player_s = GetPlayerFromServerId(sender)
    if player_s ~= -1 then
        local ped_s = GetPlayerPed(player_s)
        if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
            if IsPedInAnyVehicle(ped_s, false) then
                local veh = GetVehiclePedIsUsing(ped_s)
                setSirenState(veh, newstate)
            end
        end
    end
end)

RegisterNetEvent("els:setHornState_c")
AddEventHandler("els:setHornState_c", function(sender, newstate)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if player_s ~= -1 then
        if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
            if IsPedInAnyVehicle(ped_s, false) then
                local veh = GetVehiclePedIsUsing(ped_s)
                setHornState(veh, newstate)
            end
        end
    end
end)

RegisterNetEvent("els:setSceneLightState_c")
AddEventHandler("els:setSceneLightState_c", function(sender)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if player_s ~= -1 then
        if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
            if IsPedInAnyVehicle(ped_s, false) then
                local veh = GetVehiclePedIsUsing(ped_s)
                if (elsVehs[veh] == nil) then
                    changeLightStage(0, 1, 1, 1)
                end
                if IsVehicleExtraTurnedOn(veh, 12) then
                    setExtraState(veh, 12, 1)
                else
                    setExtraState(veh, 12, 0)
                end
            end
        end
    end
end)

RegisterNetEvent("els:setCruiseLights_c")
AddEventHandler("els:setCruiseLights_c", function(sender)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if player_s ~= -1 then
        if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
            if IsPedInAnyVehicle(ped_s, false) then
                local veh = GetVehiclePedIsUsing(ped_s)
                if elsVehs[veh] ~= nil then
                    if elsVehs[veh].cruise then
                        elsVehs[veh].cruise = false
                    else
                        elsVehs[veh].cruise = true
                    end
                else
                    elsVehs[veh] = {}
                    elsVehs[veh].cruise = true
                end
            end
        end
    end
end)

RegisterNetEvent("els:setTakedownState_c")
AddEventHandler("els:setTakedownState_c", function(sender)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if player_s ~= -1 then
        if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
            if IsPedInAnyVehicle(ped_s, false) then
                local veh = GetVehiclePedIsUsing(ped_s)
                if (elsVehs[veh] == nil) then
                    changeLightStage(0, 1, 1, 1)
                end
                if IsVehicleExtraTurnedOn(veh, 11) then
                    setExtraState(veh, 11, 1)
                else
                    setExtraState(veh, 11, 0)
                end
            end
        end
    end
end)

function toggleSirenMute(veh, toggle)
    if DoesEntityExist(veh) and not IsEntityDead(veh) then
        SetVehicleHasMutedSirens(veh, toggle)
    end
end

local function playSiren(veh, tone)
    local vcf = getVehicleVCFInfo(veh)
    m_soundID_veh[veh] = GetSoundId()

    local soundData = vcf.sounds[tone]
    local soundSet = soundData and soundData.SoundSet or 0
    local audioString = soundData and soundData.audioString or ""

    PlaySoundFromEntity(m_soundID_veh[veh], audioString, veh, soundSet, 0, 0)
    toggleSirenMute(veh, true)
end

local function playHorn(veh)
    local vcf = getVehicleVCFInfo(veh)
    h_soundID_veh[veh] = GetSoundId()

    local soundData = vcf.sounds.mainHorn
    local soundSet = soundData and soundData.SoundSet or 0
    local audioString = soundData and soundData.audioString or ""

    PlaySoundFromEntity(h_soundID_veh[veh], audioString, veh, soundSet, 0, 0)
end

function setHornState(veh, newstate)
    if DoesEntityExist(veh) and not IsEntityDead(veh) then
        if newstate ~= h_horn_state[veh] then

            if h_soundID_veh[veh] ~= nil then
                StopSound(h_soundID_veh[veh])
                ReleaseSoundId(h_soundID_veh[veh])
                h_soundID_veh[veh] = nil
            end

            if newstate == 1 then
                playHorn(veh)
            end

            h_horn_state[veh] = newstate
        end
    end
end

function setSirenState(veh, newstate)
    if DoesEntityExist(veh) and not IsEntityDead(veh) then
        if newstate ~= m_siren_state[veh] then

            if m_soundID_veh[veh] ~= nil then
                StopSound(m_soundID_veh[veh])
                ReleaseSoundId(m_soundID_veh[veh])
                m_soundID_veh[veh] = nil
            end

            if newstate == 1 then
                playSiren(veh, "srnTone1")
            elseif newstate == 2 then
                playSiren(veh, "srnTone2")
            elseif newstate == 3 then
                playSiren(veh, "srnTone3")
            else
                toggleSirenMute(veh, true)
            end

            m_siren_state[veh] = newstate
        end
    end
end

state_indic = {}

function TogIndicStateForVeh(vehicle, newstate)
    if DoesEntityExist(vehicle) and not IsEntityDead(vehicle) then
        if newstate == 0 then -- off
            SetVehicleIndicatorLights(vehicle, 0, false) -- R
            SetVehicleIndicatorLights(vehicle, 1, false) -- L
        elseif newstate == 1 then -- left
            SetVehicleIndicatorLights(vehicle, 0, false) -- R
            SetVehicleIndicatorLights(vehicle, 1, true) -- L
        elseif newstate == 2 then -- right
            SetVehicleIndicatorLights(vehicle, 0, true) -- R
            SetVehicleIndicatorLights(vehicle, 1, false) -- L
        elseif newstate == 3 then -- hazard
            SetVehicleIndicatorLights(vehicle, 0, true) -- R
            SetVehicleIndicatorLights(vehicle, 1, true) -- L
        end
        state_indic[vehicle] = newstate
    end
end

function RotAnglesToVec(rot) -- input vector3
    local z = math.rad(rot.z)
    local x = math.rad(rot.x)
    local num = math.abs(math.cos(x))
    return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
end

function changeLightStage(state, advisor, PatternPrim, PatternSec)
    TriggerServerEvent("els:changeLightStage_s", state, advisor, PatternPrim, PatternSec)
end

function checkCarHash(car)
    if car then
        for k in pairs(els_Vehicles) do
            if GetEntityModel(car) == GetHashKey(k) then
                return k
            end
        end
    end

    return "CARNOTFOUND"
end

function vehInTable(tab, val)
    for index in pairs(tab) do
        if index == val then
            return true
        end
    end

    return false
end

function setExtraState(veh, extra, state)
    if (not IsEntityDead(veh) and DoesEntityExist(veh)) then
        if els_Vehicles[checkCarHash(veh)].extras[extra] ~= nil then
            if (els_Vehicles[checkCarHash(veh)].extras[extra].enabled) then
                if DoesExtraExist(veh, extra) then
                    SetVehicleExtra(veh, extra, state)
                end
            end
        end
    end
end

function getVehicleLightStage(veh)

    if (elsVehs[veh] ~= nil) then
        return elsVehs[veh].stage
    end
end

function Draw(text, r, g, b, alpha, x, y, width, height, ya, center, font)
    SetTextColour(r, g, b, alpha)
    SetTextFont(font)
    SetTextScale(width, height)
    SetTextWrap(0.0, 1.0)
    SetTextCentre(center)
    SetTextDropshadow(0, 0, 0, 0, 0)
    SetTextEdge(1, 0, 0, 0, 205)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetUiLayer(ya)
    EndTextCommandDisplayText(x, y)
end

function _DrawRect(x, y, width, height, r, g, b, a, ya)
    SetUiLayer(ya)
    DrawRect(x, y, width, height, r, g, b, a)
end

function setSirenStateButton(state)
    if Config.playButtonPressSounds then
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
    if m_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] ~= state then
        TriggerServerEvent("els:setSirenState_s", state)
    elseif m_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == state then
        TriggerServerEvent("els:setSirenState_s", 0)
    end
end

function upOneStage()
    if Config.playButtonPressSounds then
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
    local vehNetID = GetVehiclePedIsUsing(GetPlayerPed(-1))

    local newStage = 1

    if (elsVehs[vehNetID] ~= nil and elsVehs[vehNetID].stage ~= nil) then
        newStage = elsVehs[vehNetID].stage + 1
    end

    if newStage == 4 then
        newStage = 0
    end

    changeLightStage(newStage, advisorPatternSelectedIndex, lightPatternPrim, lightPatternSec)

    if GetVehicleClass(GetVehiclePedIsUsing(GetPlayerPed(-1))) == 18 then
        if newStage == getVehicleVCFInfo(GetVehiclePedIsUsing(GetPlayerPed(-1))).misc.dfltsirenltsactivateatlstg then
            toggleSirenMute(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
            SetVehicleSiren(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
        else
            SetVehicleSiren(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
        end

        if (newStage == 0) then
            SetVehicleSiren(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
            TriggerServerEvent("els:setSirenState_s", 0)
            TriggerServerEvent("els:setDualSirenState_s", 0)
            TriggerServerEvent("els:setDualSiren_s", false)
        end
    end
end

function downOneStage()
    if Config.playButtonPressSounds then
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
    local vehNetID = GetVehiclePedIsUsing(GetPlayerPed(-1))

    local newStage = 3

    if (elsVehs[vehNetID] ~= nil and elsVehs[vehNetID].stage ~= nil) then
        newStage = elsVehs[vehNetID].stage - 1
    end

    if newStage == -1 then
        newStage = 3
    end

    changeLightStage(newStage, advisorPatternSelectedIndex, lightPatternPrim, lightPatternSec)

    if GetVehicleClass(GetVehiclePedIsUsing(GetPlayerPed(-1))) == 18 then
        if newStage == getVehicleVCFInfo(GetVehiclePedIsUsing(GetPlayerPed(-1))).misc.dfltsirenltsactivateatlstg then
            toggleSirenMute(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
            SetVehicleSiren(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
        else
            SetVehicleSiren(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
        end

        if (newStage == 0) then
            SetVehicleSiren(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
            TriggerServerEvent("els:setSirenState_s", 0)
            TriggerServerEvent("els:setDualSirenState_s", 0)
            TriggerServerEvent("els:setDualSiren_s", false)
        end
    end
end

function formatPatternNumber(num)
    if num < 10 then
        return "00" .. tostring(num)
    elseif num < 100 and num >= 10 then
        return "0" .. tostring(num)
    else
        return tostring(num)
    end
end

function getVehicleVCFInfo(veh)
    return els_Vehicles[checkCarHash(veh)] or false
end

ped = 0
current_vehicle = 0
isVehicleELS = false
canControlELS = false
Citizen.CreateThread(function()
    Wait(500)
    while true do
        isVehicleELS = false
        canControlELS = false
        if current_vehicle ~= 0 then
            if (els_Vehicles ~= nil) then
                isVehicleELS = vehInTable(els_Vehicles, checkCarHash(current_vehicle))
            end
            if isVehicleELS then
                if GetPedInVehicleSeat(current_vehicle, -1) == ped or GetPedInVehicleSeat(current_vehicle, 0) == ped then
                    canControlELS = true
                end
                debugPrint('isVehicleELS = ' .. tostring(isVehicleELS), false, true)
                debugPrint('canControlELS = ' .. tostring(canControlELS), false, true)
            else
                canControlELS = false
            end
        else
            isVehicleELS = false
            canControlELS = false
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        ped = PlayerPedId()
        current_vehicle = GetVehiclePedIsIn(ped, false)
        Citizen.Wait(500)
    end
end)

function ShowNotification(text)
    local eName = 'HUD_NOTIFICATION_' .. string.sub(text, string.len(text) - 4) .. ' - ' .. GetGameTimer()
    AddTextEntry(eName, text)
    SetNotificationTextEntry(eName)
    DrawNotification(false, false)
end

RegisterNetEvent("els:notify")
AddEventHandler("els:notify", function(text)
    ShowNotification(text)
end)

RegisterNetEvent("els:setPanelType")
AddEventHandler("els:setPanelType", function(pType)
    local validPanel = false
    for _, panel in pairs(Config.allowedPanelTypes) do
        if panel == pType then
            validPanel = true
            break
        end
    end

    if validPanel then
        SetResourceKvp("els:panelType", pType)
        debugPrint("Set panel type to " .. pType)
        ShowNotification("~r~ELS~s~~n~Set panel type to " .. pType)
        panelTypeChanged = true
        return
    end

    ShowNotification("~r~ELS~s~~n~Invalid panel type (" .. pType .. ")")
end)

local firstSpawn = true
AddEventHandler("playerSpawned", function()
    if EGetConvarBool("els_developer") then
        if firstSpawn then
            TriggerServerEvent("els:playerSpawned")
            firstSpawn = false
        end
    end
end)

local orig = _G.Citizen.Trace
_G.Citizen.Trace = function(data)
    orig(data)
    if string.match(data, "SCRIPT ERROR") then
        TriggerServerEvent("els:catchError", data, current_vehicle)
    end
end