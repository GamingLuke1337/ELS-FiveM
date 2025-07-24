els_Vehicles = {}

RequestScriptAudioBank("DLC_WMSIRENS\\SIRENPACK_ONE", false)

advisorPatternSelectedIndex = 1

lightPatternPrim = 0
lightPatternsPrim = 1
lightPatternSec = 1

elsVehs = {}

m_siren_state = {}
m_soundID_veh = {}
d_siren_state = {}
d_soundID_veh = {}
h_horn_state = {}
h_soundID_veh = {}
local dualEnable = {}
local vehicle = nil
local lastVehicleStates = {}

local networkSessionActive = true

if IsPedInAnyVehicle(ped, false) then
    vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle ~= lastVehicle then
        SetVehicleRadioEnabled(vehicle, false)
        lastVehicle = vehicle
    end
end

CreateThread(function()

    TriggerServerEvent("els:requestVehiclesUpdate")

    while true do

        if EGetConvarBool("els_developer") then

            -- a temporary condition for split session handling
            if not NetworkIsSessionActive() then
                print("Not in network session, shit will significantly fuck up, so we're preventing you from using ELS.")
                networkSessionActive = false
            else
                networkSessionActive = true
            end
        end

        if isVehicleELS and canControlELS and networkSessionActive then

            if GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId())) == 18 then
                DisableControlAction(0, Config.shared.horn, true)
            end

            DisableControlAction(0, 84, true) -- INPUT_VEH_PREV_RADIO_TRACK  
            DisableControlAction(0, 83, true) -- INPUT_VEH_NEXT_RADIO_TRACK 
            DisableControlAction(0, 81, true) -- INPUT_VEH_NEXT_RADIO
            DisableControlAction(0, 82, true) -- INPUT_VEH_PREV_RADIO

            if (GetLastInputMethod(0)) then
                DisableControlAction(0, Config.keyboard.stageChange, true)

                DisableControlAction(0, Config.keyboard.pattern.primary, true)
                DisableControlAction(0, Config.keyboard.pattern.secondary, true)
                DisableControlAction(0, Config.keyboard.pattern.advisor, true)
                DisableControlAction(0, Config.keyboard.modifyKey, true)

                DisableControlAction(0, Config.keyboard.siren.tone_one, true)
                DisableControlAction(0, Config.keyboard.siren.tone_two, true)
                DisableControlAction(0, Config.keyboard.siren.tone_three, true)

                DisableControlAction(0, Config.keyboard.hazard.hazard_key, true)
                DisableControlAction(0, Config.keyboard.hazard.left_signal_key, true)
                DisableControlAction(0, Config.keyboard.hazard.right_signal_key, true)

                if IsDisabledControlJustReleased(0, Config.keyboard.hazard.left_signal_key) then
                    vehicle = GetVehiclePedIsUsing(PlayerPedId())
                    if state_indic[vehicle] == 1 then
                        TogIndicStateForVeh(vehicle, 0)
                    else
                        TogIndicStateForVeh(vehicle, 1)
                    end
                elseif IsDisabledControlJustReleased(0, Config.keyboard.hazard.right_signal_key) then
                    vehicle = GetVehiclePedIsUsing(PlayerPedId())
                    if state_indic[vehicle] == 2 then
                        TogIndicStateForVeh(vehicle, 0)
                    else
                        TogIndicStateForVeh(vehicle, 2)
                    end
                elseif IsDisabledControlJustReleased(0, Config.keyboard.hazard.hazard_key) then
                    vehicle = GetVehiclePedIsUsing(PlayerPedId())
                    if state_indic[vehicle] == 3 then
                        TogIndicStateForVeh(vehicle, 0)
                    else
                        TogIndicStateForVeh(vehicle, 3)
                    end
                end

                if IsDisabledControlPressed(0, Config.keyboard.modifyKey) then

                    if IsDisabledControlJustReleased(0, Config.keyboard.guiKey) then
                        if Config.playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
                        if Config.panelEnabled then
                            Config.panelEnabled = false
                        else
                            Config.panelEnabled = true
                        end
                    end

                    if IsDisabledControlJustReleased(0, Config.keyboard.stageChange) then
                        if getVehicleVCFInfo(GetVehiclePedIsUsing(PlayerPedId())).interface.activationType == "invert" or
                            getVehicleVCFInfo(GetVehiclePedIsUsing(PlayerPedId())).interface.activationType == "euro" then
                            upOneStage()
                        else
                            downOneStage()
                        end
                    end
                    if IsDisabledControlJustReleased(0, Config.keyboard.takedown) then
                        if Config.playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
                        TriggerServerEvent("els:setSceneLightState_s")
                    end
                else
                    if IsDisabledControlJustReleased(0, Config.keyboard.stageChange) then
                        if getVehicleVCFInfo(GetVehiclePedIsUsing(PlayerPedId())).interface.activationType == "invert" or
                            getVehicleVCFInfo(GetVehiclePedIsUsing(PlayerPedId())).interface.activationType == "euro" then
                            downOneStage()
                        else
                            upOneStage()
                        end
                    end
                    if IsDisabledControlJustReleased(0, Config.keyboard.takedown) then
                        if Config.playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
                        TriggerServerEvent("els:setTakedownState_s")
                    end
                    if IsDisabledControlJustReleased(0, 84) then
                        if Config.playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
                        TriggerServerEvent("els:setCruiseLights_s")
                    end
                    if IsDisabledControlJustReleased(0, Config.keyboard.warning) then
                        if Config.playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
                        if elsVehs[GetVehiclePedIsUsing(PlayerPedId())] ~= nil then
                            if elsVehs[GetVehiclePedIsUsing(PlayerPedId())].warning then
                                TriggerServerEvent("els:changePartState_s", "warning", false)
                            else
                                TriggerServerEvent("els:changePartState_s", "warning", true)
                            end
                        else
                            TriggerServerEvent("els:changePartState_s", "warning", true)
                        end
                    end
                    if IsDisabledControlJustReleased(0, Config.keyboard.secondary) then
                        if Config.playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
                        if elsVehs[GetVehiclePedIsUsing(PlayerPedId())] ~= nil then
                            if elsVehs[GetVehiclePedIsUsing(PlayerPedId())].secondary then
                                TriggerServerEvent("els:changePartState_s", "secondary", false)
                            else
                                TriggerServerEvent("els:changePartState_s", "secondary", true)
                            end
                        else
                            TriggerServerEvent("els:changePartState_s", "secondary", true)
                        end
                    end
                    if IsDisabledControlJustPressed(0, Config.keyboard.primary) then
                        if Config.playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
                        if elsVehs[GetVehiclePedIsUsing(PlayerPedId())] ~= nil then
                            if elsVehs[GetVehiclePedIsUsing(PlayerPedId())].primary then
                                TriggerServerEvent("els:changePartState_s", "primary", false)
                            else
                                TriggerServerEvent("els:changePartState_s", "primary", true)
                            end
                        else
                            TriggerServerEvent("els:changePartState_s", "primary", true)
                        end
                    end
                end

                if GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId())) == 18 then
                    if (elsVehs[GetVehiclePedIsUsing(PlayerPedId())] ~= nil) then
                        if elsVehs[GetVehiclePedIsUsing(PlayerPedId())].stage == 3 then
                            if IsDisabledControlJustReleased(0, Config.keyboard.siren.tone_one) then
                                setSirenStateButton(1)
                            end
                            if IsDisabledControlJustReleased(0, Config.keyboard.siren.tone_two) then
                                setSirenStateButton(2)
                            end
                            if IsDisabledControlJustReleased(0, Config.keyboard.siren.tone_three) then
                                setSirenStateButton(3)
                            end
                        end
                        if elsVehs[GetVehiclePedIsUsing(PlayerPedId())].stage == 2 then
                            if IsDisabledControlJustReleased(0, Config.keyboard.siren.tone_one) then
                                if Config.playButtonPressSounds then
                                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                end
                                TriggerServerEvent("els:setSirenState_s", 0)
                            end
                            if IsDisabledControlJustPressed(0, Config.keyboard.siren.tone_one) then
                                if Config.playButtonPressSounds then
                                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                end
                                TriggerServerEvent("els:setSirenState_s", 1)
                            end

                            if IsDisabledControlJustReleased(0, Config.keyboard.siren.tone_two) then
                                if Config.playButtonPressSounds then
                                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                end
                                TriggerServerEvent("els:setSirenState_s", 0)
                            end
                            if IsDisabledControlJustPressed(0, Config.keyboard.siren.tone_two) then
                                if Config.playButtonPressSounds then
                                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                end
                                TriggerServerEvent("els:setSirenState_s", 2)
                            end

                            if IsDisabledControlJustReleased(0, Config.keyboard.siren.tone_three) then
                                if Config.playButtonPressSounds then
                                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                end
                                TriggerServerEvent("els:setSirenState_s", 0)
                            end
                            if IsDisabledControlJustPressed(0, Config.keyboard.siren.tone_three) then
                                if Config.playButtonPressSounds then
                                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                end
                                TriggerServerEvent("els:setSirenState_s", 3)
                            end
                        end
                    end
                end

            else
                DisableControlAction(0, Config.controller.modifyKey, true)
                DisableControlAction(0, Config.controller.stageChange, true)
                DisableControlAction(0, Config.controller.siren.tone_one, true)
                DisableControlAction(0, Config.controller.siren.tone_two, true)
                DisableControlAction(0, Config.controller.siren.tone_three, true)

                if els_Vehicles[checkCarHash(GetVehiclePedIsUsing(PlayerPedId()))] ~= nil and
                    els_Vehicles[checkCarHash(GetVehiclePedIsUsing(PlayerPedId()))].activateUp then
                    if IsDisabledControlPressed(0, Config.controller.modifyKey) and
                        IsDisabledControlJustReleased(0, Config.controller.stageChange) then
                        downOneStage()
                    elseif IsDisabledControlJustReleased(0, Config.controller.stageChange) then
                        upOneStage()
                    end
                else
                    if IsDisabledControlJustReleased(0, Config.controller.stageChange) then
                        downOneStage()
                    elseif IsDisabledControlPressed(0, Config.controller.modifyKey) and
                        IsDisabledControlJustReleased(0, Config.controller.stageChange) then
                        upOneStage()
                    end
                end

                if IsDisabledControlPressed(0, Config.controller.modifyKey) then
                    DisableControlAction(0, Config.controller.takedown, true)
                    if IsDisabledControlPressed(0, Config.controller.modifyKey) and
                        IsDisabledControlJustReleased(0, Config.controller.takedown) then
                        if Config.playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
                        TriggerServerEvent("els:setTakedownState_s")
                    end
                end

                if GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId())) == 18 then
                    if (elsVehs[GetVehiclePedIsUsing(PlayerPedId())] ~= nil) then
                        if elsVehs[GetVehiclePedIsUsing(PlayerPedId())].stage == 3 then
                            if not IsDisabledControlPressed(0, Config.controller.modifyKey) then
                                if IsDisabledControlJustReleased(0, Config.controller.siren.tone_one) then
                                    setSirenStateButton(1)
                                end
                                if IsDisabledControlJustReleased(0, Config.controller.siren.tone_two) then
                                    setSirenStateButton(2)
                                end
                                if IsDisabledControlJustReleased(0, Config.controller.siren.tone_three) then
                                    setSirenStateButton(3)
                                end
                            end

                        end
                        if elsVehs[GetVehiclePedIsUsing(PlayerPedId())].stage == 2 then
                            if IsDisabledControlJustReleased(0, Config.controller.siren.tone_one) then
                                if Config.playButtonPressSounds then
                                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                end
                                TriggerServerEvent("els:setSirenState_s", 0)
                            end
                            if IsDisabledControlJustPressed(0, Config.controller.siren.tone_one) then
                                if Config.playButtonPressSounds then
                                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                end
                                TriggerServerEvent("els:setSirenState_s", 1)
                            end

                            if IsDisabledControlJustReleased(0, Config.controller.siren.tone_two) then
                                if Config.playButtonPressSounds then
                                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                end
                                TriggerServerEvent("els:setSirenState_s", 0)
                            end
                            if IsDisabledControlJustPressed(0, Config.controller.siren.tone_two) then
                                if Config.playButtonPressSounds then
                                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                end
                                TriggerServerEvent("els:setSirenState_s", 2)
                            end

                            if IsDisabledControlJustReleased(0, Config.controller.siren.tone_three) then
                                if Config.playButtonPressSounds then
                                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                end
                                TriggerServerEvent("els:setSirenState_s", 0)
                            end
                            if IsDisabledControlJustPressed(0, Config.controller.siren.tone_three) then
                                if Config.playButtonPressSounds then
                                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                end
                                TriggerServerEvent("els:setSirenState_s", 3)
                            end
                        end
                    end
                end
            end

            if GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId())) == 18 then
                if not IsDisabledControlPressed(0, Config.controller.modifyKey) then
                    if (IsDisabledControlJustPressed(0, Config.shared.horn)) then
                        TriggerServerEvent("els:setHornState_s", 1)
                    end

                    if (IsDisabledControlJustReleased(0, Config.shared.horn)) then
                        TriggerServerEvent("els:setHornState_s", 0)
                    end
                end
            end
        end

        Citizen.Wait(0)
    end
end)

CreateThread(function()
    while true do
        if isVehicleELS and canControlELS then

            if IsDisabledControlPressed(0, Config.keyboard.modifyKey) then
                if IsDisabledControlPressed(0, Config.keyboard.pattern.primary) then
                    if Config.playButtonPressSounds then
                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                    end
                    changePrimaryPatternMath(-1)
                end
                if IsDisabledControlPressed(0, Config.keyboard.pattern.secondary) then
                    if Config.playButtonPressSounds then
                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                    end
                    changeSecondaryPatternMath(-1)
                end
                if IsDisabledControlPressed(0, Config.keyboard.pattern.advisor) then
                    if Config.playButtonPressSounds then
                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                    end
                    changeAdvisorPatternMath(-1)
                end
            else
                if IsDisabledControlPressed(0, Config.keyboard.pattern.primary) then
                    if Config.playButtonPressSounds then
                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                    end
                    changePrimaryPatternMath(1)
                end
                if IsDisabledControlPressed(0, Config.keyboard.pattern.secondary) then
                    if Config.playButtonPressSounds then
                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                    end
                    changeSecondaryPatternMath(1)
                end
                if IsDisabledControlPressed(0, Config.keyboard.pattern.advisor) then
                    if Config.playButtonPressSounds then
                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                    end
                    changeAdvisorPatternMath(1)
                end
            end
        end
        Wait(150)
    end
end)

local log = false
RegisterCommand('tlog', function()
    log = not log
    if log then
        print('now logging stuff')
    end
end)

CreateThread(function()
    while true do
        Wait(500)
        if log then
            print("elsVehs:" .. json.encode(elsVehs))
            print("els_Vehicles:" .. json.encode(els_Vehicles))
        end
    end
end)

local allowedPanel = false
local panelTypeChecked = false
panelTypeChanged = false
CreateThread(function()
    while true do
        if Config.panelOffsetX ~= nil and Config.panelOffsetY ~= nil then
            if Config.panelEnabled and isVehicleELS then
                if canControlELS then
                    local vehN = GetVehiclePedIsUsing(GetPlayerPed(-1))

                    if panelTypeChanged then
                        local panelT = GetResourceKvpString("els:panelType")
                        if panelT then
                            Config.panelType = panelT
                            panelTypeChecked = false
                        end
                        panelTypeChanged = false
                    end

                    if not panelTypeChecked then
                        for _, v in pairs(Config.allowedPanelTypes) do
                            if v == Config.panelType then
                                allowedPanel = true
                                break
                            end
                        end
                        panelTypeChecked = true
                    end

                    if not allowedPanel then
                        error(string.format(
                            "This panel type (%s) is not supported. If you did not do anything to invoke this error, contact the server owner.",
                            Config.panelType))
                    end

                    if vehN ~= 0 then
                        if EGetConvarBool("els_developer") then
                            Draw("~o~DEVELOPER MODE", 0, 0, 0, 255, 0.932 + Config.panelOffsetX,
                                0.856 + Config.panelOffsetY, 0.25, 0.25, 1, true, 0)
                        end

                        if (Config.panelType == "original") then
                            _DrawRect(0.85 + Config.panelOffsetX, 0.89 + Config.panelOffsetY, 0.26, 0.16, 16, 16, 16,
                                225, 0)

                            _DrawRect(0.85 + Config.panelOffsetX, 0.835 + Config.panelOffsetY, 0.245, 0.035, 0, 0, 0,
                                225, 0)
                            _DrawRect(0.85 + Config.panelOffsetX, 0.835 + Config.panelOffsetY, 0.24, 0.03,
                                getVehicleVCFInfo(vehN).interface.headerColor.r,
                                getVehicleVCFInfo(vehN).interface.headerColor.g,
                                getVehicleVCFInfo(vehN).interface.headerColor.b, 225, 0)
                            Draw("MAIN", 0, 0, 0, 255, 0.745 + Config.panelOffsetX, 0.825 + Config.panelOffsetY, 0.25,
                                0.25, 1, true, 0)
                            Draw("Test-ELS", 0, 0, 0, 255, 0.92 + Config.panelOffsetX, 0.825 + Config.panelOffsetY,
                                0.25, 0.25, 1, true, 0)

                            _DrawRect(0.78 + Config.panelOffsetX, 0.835 + Config.panelOffsetY, 0.033, 0.025, 0, 0, 0,
                                225, 0)
                            if (getVehicleLightStage(GetVehiclePedIsUsing(GetPlayerPed(-1))) == 1) then
                                _DrawRect(0.78 + Config.panelOffsetX, 0.835 + Config.panelOffsetY, 0.03, 0.02,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                                Draw("S-1", 0, 0, 0, 255, 0.78 + Config.panelOffsetX, 0.825 + Config.panelOffsetY, 0.25,
                                    0.25, 1, true, 0)
                            else
                                _DrawRect(0.78 + Config.panelOffsetX, 0.835 + Config.panelOffsetY, 0.03, 0.02, 186, 186,
                                    186, 225, 0)
                                Draw("S-1", 0, 0, 0, 255, 0.78 + Config.panelOffsetX, 0.825 + Config.panelOffsetY, 0.25,
                                    0.25, 1, true, 0)
                            end

                            _DrawRect(0.815 + Config.panelOffsetX, 0.835 + Config.panelOffsetY, 0.033, 0.025, 0, 0, 0,
                                225, 0)
                            if (getVehicleLightStage(GetVehiclePedIsUsing(GetPlayerPed(-1))) == 2) then
                                _DrawRect(0.815 + Config.panelOffsetX, 0.835 + Config.panelOffsetY, 0.03, 0.02,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                                Draw("S-2", 0, 0, 0, 255, 0.815 + Config.panelOffsetX, 0.825 + Config.panelOffsetY,
                                    0.25, 0.25, 1, true, 0)
                            else
                                _DrawRect(0.815 + Config.panelOffsetX, 0.835 + Config.panelOffsetY, 0.03, 0.02, 186,
                                    186, 186, 225, 0)
                                Draw("S-2", 0, 0, 0, 255, 0.815 + Config.panelOffsetX, 0.825 + Config.panelOffsetY,
                                    0.25, 0.25, 1, true, 0)
                            end

                            _DrawRect(0.850 + Config.panelOffsetX, 0.835 + Config.panelOffsetY, 0.033, 0.025, 0, 0, 0,
                                225, 0)
                            if (getVehicleLightStage(GetVehiclePedIsUsing(GetPlayerPed(-1))) == 3) then
                                _DrawRect(0.850 + Config.panelOffsetX, 0.835 + Config.panelOffsetY, 0.03, 0.02,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                                Draw("S-3", 0, 0, 0, 255, 0.850 + Config.panelOffsetX, 0.825 + Config.panelOffsetY,
                                    0.25, 0.25, 1, true, 0)
                            else
                                _DrawRect(0.850 + Config.panelOffsetX, 0.835 + Config.panelOffsetY, 0.03, 0.02, 186,
                                    186, 186, 225, 0)
                                Draw("S-3", 0, 0, 0, 255, 0.850 + Config.panelOffsetX, 0.825 + Config.panelOffsetY,
                                    0.25, 0.25, 1, true, 0)
                            end

                            _DrawRect(0.742 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.028, 0.045, 0, 0, 0,
                                225, 0)
                            if elsVehs[GetVehiclePedIsUsing(GetPlayerPed(-1))] ~= nil then
                                if elsVehs[GetVehiclePedIsUsing(GetPlayerPed(-1))].warning then
                                    _DrawRect(0.7421 + Config.panelOffsetX, 0.871 + Config.panelOffsetY, 0.026, 0.02,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                                    Draw("E-" .. formatPatternNumber(advisorPatternSelectedIndex),
                                        getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.b, 255,
                                        0.7423 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.25, 0.25, 1, true, 0)
                                else
                                    _DrawRect(0.7421 + Config.panelOffsetX, 0.871 + Config.panelOffsetY, 0.026, 0.02,
                                        186, 186, 186, 225, 0)
                                    Draw("E-" .. formatPatternNumber(advisorPatternSelectedIndex), 255, 255, 255, 255,
                                        0.7423 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.25, 0.25, 1, true, 0)
                                end
                            else
                                _DrawRect(0.7421 + Config.panelOffsetX, 0.871 + Config.panelOffsetY, 0.026, 0.02, 186,
                                    186, 186, 225, 0)
                                Draw("E-" .. formatPatternNumber(advisorPatternSelectedIndex), 255, 255, 255, 255,
                                    0.7423 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.25, 0.25, 1, true, 0)
                            end
                            Draw("WRN", 0, 0, 0, 255, 0.7423 + Config.panelOffsetX, 0.86 + Config.panelOffsetY, 0.25,
                                0.25, 1, true, 0)

                            _DrawRect(0.774 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.028, 0.045, 0, 0, 0,
                                225, 0)
                            if elsVehs[GetVehiclePedIsUsing(GetPlayerPed(-1))] ~= nil then
                                if elsVehs[GetVehiclePedIsUsing(GetPlayerPed(-1))].secondary then
                                    _DrawRect(0.774 + Config.panelOffsetX, 0.871 + Config.panelOffsetY, 0.025, 0.02,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                                    Draw("E-" .. formatPatternNumber(lightPatternSec),
                                        getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.b, 255,
                                        0.774 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.25, 0.25, 1, true, 0)
                                else
                                    _DrawRect(0.774 + Config.panelOffsetX, 0.871 + Config.panelOffsetY, 0.025, 0.02,
                                        186, 186, 186, 225, 0)
                                    Draw("E-" .. formatPatternNumber(lightPatternSec), 255, 255, 255, 255,
                                        0.774 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.25, 0.25, 1, true, 0)
                                end
                            else
                                _DrawRect(0.774 + Config.panelOffsetX, 0.871 + Config.panelOffsetY, 0.025, 0.02, 186,
                                    186, 186, 225, 0)
                                Draw("E-" .. formatPatternNumber(lightPatternSec), 255, 255, 255, 255,
                                    0.774 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.25, 0.25, 1, true, 0)
                            end
                            Draw("SEC", 0, 0, 0, 255, 0.774 + Config.panelOffsetX, 0.86 + Config.panelOffsetY, 0.25,
                                0.25, 1, true, 0)

                            _DrawRect(0.806 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.028, 0.045, 0, 0, 0,
                                225, 0)
                            if elsVehs[GetVehiclePedIsUsing(GetPlayerPed(-1))] ~= nil then
                                if elsVehs[GetVehiclePedIsUsing(GetPlayerPed(-1))].primary then
                                    _DrawRect(0.806 + Config.panelOffsetX, 0.871 + Config.panelOffsetY, 0.025, 0.02,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                                    Draw("E-" .. formatPatternNumber(lightPatternPrim),
                                        getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.b, 255,
                                        0.806 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.25, 0.25, 1, true, 0)
                                else
                                    _DrawRect(0.806 + Config.panelOffsetX, 0.871 + Config.panelOffsetY, 0.025, 0.02,
                                        186, 186, 186, 225, 0)
                                    Draw("E-" .. formatPatternNumber(lightPatternPrim), 255, 255, 255, 255,
                                        0.806 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.25, 0.25, 1, true, 0)
                                end
                            else
                                _DrawRect(0.806 + Config.panelOffsetX, 0.871 + Config.panelOffsetY, 0.025, 0.02, 186,
                                    186, 186, 225, 0)
                                Draw("E-" .. formatPatternNumber(lightPatternPrim), 255, 255, 255, 255,
                                    0.806 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.25, 0.25, 1, true, 0)
                            end
                            Draw("PRIM", 0, 0, 0, 255, 0.806 + Config.panelOffsetX, 0.86 + Config.panelOffsetY, 0.25,
                                0.25, 1, true, 0)

                            _DrawRect(0.742 + Config.panelOffsetX, 0.93 + Config.panelOffsetY, 0.028, 0.045, 0, 0, 0,
                                225, 0)
                            _DrawRect(0.7421 + Config.panelOffsetX, 0.921 + Config.panelOffsetY, 0.026, 0.02, 186, 186,
                                186, 225, 0)
                            Draw("--", 255, 255, 255, 255, 0.7423 + Config.panelOffsetX, 0.93 + Config.panelOffsetY,
                                0.25, 0.25, 1, true, 0)
                            Draw("HRN", 0, 0, 0, 255, 0.7423 + Config.panelOffsetX, 0.91 + Config.panelOffsetY, 0.25,
                                0.25, 1, true, 0)

                            _DrawRect(0.86 + Config.panelOffsetX, 0.911 + Config.panelOffsetY, 0.06, 0.09, 0, 0, 0, 225,
                                0)

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 11)) then
                                _DrawRect(0.853 + Config.panelOffsetX, 0.895 + Config.panelOffsetY, 0.01, 0.005, 255,
                                    255, 255, 225, 0)
                                _DrawRect(0.866 + Config.panelOffsetX, 0.895 + Config.panelOffsetY, 0.01, 0.005, 255,
                                    255, 255, 225, 0)
                            else
                                _DrawRect(0.853 + Config.panelOffsetX, 0.895 + Config.panelOffsetY, 0.01, 0.005, 54, 54,
                                    54, 225, 0)
                                _DrawRect(0.866 + Config.panelOffsetX, 0.895 + Config.panelOffsetY, 0.01, 0.005, 54, 54,
                                    54, 225, 0)
                            end

                            _DrawRect(0.8365 + Config.panelOffsetX, 0.9 + Config.panelOffsetY, 0.0029, 0.015, 54, 54,
                                54, 225, 0)

                            _DrawRect(0.882 + Config.panelOffsetX, 0.9 + Config.panelOffsetY, 0.0029, 0.015, 54, 54, 54,
                                225, 0)

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 7)) then
                                _DrawRect(0.848 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.01, 0.015,
                                    getVehicleVCFInfo(vehN).extras[7].env_color.r,
                                    getVehicleVCFInfo(vehN).extras[7].env_color.g,
                                    getVehicleVCFInfo(vehN).extras[7].env_color.b, 225, 0)
                            else
                                _DrawRect(0.848 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.01, 0.015, 54, 54,
                                    54, 225, 0)
                            end

                            if getVehicleVCFInfo(vehN).secl.type == "traf" or getVehicleVCFInfo(vehN).secl.type == "chp" then
                                if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 8)) then
                                    _DrawRect(0.8598 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.01, 0.015,
                                        getVehicleVCFInfo(vehN).extras[8].env_color.r,
                                        getVehicleVCFInfo(vehN).extras[8].env_color.g,
                                        getVehicleVCFInfo(vehN).extras[8].env_color.b, 225, 0)
                                else
                                    _DrawRect(0.8598 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.01, 0.015, 54,
                                        54, 54, 225, 0)
                                end
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 9)) then
                                _DrawRect(0.872 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.01, 0.015,
                                    getVehicleVCFInfo(vehN).extras[9].env_color.r,
                                    getVehicleVCFInfo(vehN).extras[9].env_color.g,
                                    getVehicleVCFInfo(vehN).extras[9].env_color.b, 225, 0)
                            else
                                _DrawRect(0.872 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.01, 0.015, 54, 54,
                                    54, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1)) then
                                _DrawRect(0.84 + Config.panelOffsetX, 0.92 + Config.panelOffsetY, 0.01, 0.015,
                                    getVehicleVCFInfo(vehN).extras[1].env_color.r,
                                    getVehicleVCFInfo(vehN).extras[1].env_color.g,
                                    getVehicleVCFInfo(vehN).extras[1].env_color.b, 225, 0)
                            else
                                _DrawRect(0.84 + Config.panelOffsetX, 0.92 + Config.panelOffsetY, 0.01, 0.015, 54, 54,
                                    54, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 2)) then
                                _DrawRect(0.853 + Config.panelOffsetX, 0.92 + Config.panelOffsetY, 0.01, 0.015,
                                    getVehicleVCFInfo(vehN).extras[2].env_color.r,
                                    getVehicleVCFInfo(vehN).extras[2].env_color.g,
                                    getVehicleVCFInfo(vehN).extras[2].env_color.b, 225, 0)
                            else
                                _DrawRect(0.853 + Config.panelOffsetX, 0.92 + Config.panelOffsetY, 0.01, 0.015, 54, 54,
                                    54, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 3)) then
                                _DrawRect(0.866 + Config.panelOffsetX, 0.92 + Config.panelOffsetY, 0.01, 0.015,
                                    getVehicleVCFInfo(vehN).extras[3].env_color.r,
                                    getVehicleVCFInfo(vehN).extras[3].env_color.g,
                                    getVehicleVCFInfo(vehN).extras[3].env_color.b, 225, 0)
                            else
                                _DrawRect(0.866 + Config.panelOffsetX, 0.92 + Config.panelOffsetY, 0.01, 0.015, 54, 54,
                                    54, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 4)) then
                                _DrawRect(0.879 + Config.panelOffsetX, 0.92 + Config.panelOffsetY, 0.01, 0.015,
                                    getVehicleVCFInfo(vehN).extras[4].env_color.r,
                                    getVehicleVCFInfo(vehN).extras[4].env_color.g,
                                    getVehicleVCFInfo(vehN).extras[4].env_color.b, 225, 0)
                            else
                                _DrawRect(0.879 + Config.panelOffsetX, 0.92 + Config.panelOffsetY, 0.01, 0.015, 54, 54,
                                    54, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 5)) then
                                _DrawRect(0.853 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.01, 0.015,
                                    getVehicleVCFInfo(vehN).extras[5].env_color.r,
                                    getVehicleVCFInfo(vehN).extras[5].env_color.g,
                                    getVehicleVCFInfo(vehN).extras[5].env_color.b, 225, 0)
                            else
                                _DrawRect(0.853 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.01, 0.015, 54, 54,
                                    54, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 6)) then
                                _DrawRect(0.866 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.01, 0.015,
                                    getVehicleVCFInfo(vehN).extras[6].env_color.r,
                                    getVehicleVCFInfo(vehN).extras[6].env_color.g,
                                    getVehicleVCFInfo(vehN).extras[6].env_color.b, 225, 0)
                            else
                                _DrawRect(0.866 + Config.panelOffsetX, 0.88 + Config.panelOffsetY, 0.01, 0.015, 54, 54,
                                    54, 225, 0)
                            end

                            _DrawRect(0.91 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.024, 0.023, 0, 0, 0,
                                225, 0)
                            if elsVehs[GetVehiclePedIsUsing(GetPlayerPed(-1))] ~= nil then
                                if elsVehs[GetVehiclePedIsUsing(GetPlayerPed(-1))].cruise then
                                    _DrawRect(0.91 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.022, 0.02,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                        getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                                else
                                    _DrawRect(0.91 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.022, 0.02, 186,
                                        186, 186, 225, 0)
                                end
                            else
                                _DrawRect(0.91 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.0215, 0.02, 186,
                                    186, 186, 225, 0)
                            end
                            Draw("CRS", 0, 0, 0, 255, 0.91 + Config.panelOffsetX, 0.93 + Config.panelOffsetY, 0.25,
                                0.25, 1, true, 0)

                            _DrawRect(0.935 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.024, 0.023, 0, 0, 0,
                                225, 0)
                            if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 11) then
                                _DrawRect(0.935 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.022, 0.02,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                            else
                                _DrawRect(0.935 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.0215, 0.02, 186,
                                    186, 186, 225, 0)
                            end
                            Draw("TKD", 0, 0, 0, 255, 0.935 + Config.panelOffsetX, 0.93 + Config.panelOffsetY, 0.25,
                                0.25, 1, true, 0)

                            _DrawRect(0.96 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.024, 0.023, 0, 0, 0,
                                225, 0)
                            if IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 12) then
                                _DrawRect(0.96 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.022, 0.02,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                            else
                                _DrawRect(0.96 + Config.panelOffsetX, 0.94 + Config.panelOffsetY, 0.0215, 0.02, 186,
                                    186, 186, 225, 0)
                            end
                            Draw("SCL", 0, 0, 0, 255, 0.96 + Config.panelOffsetX, 0.93 + Config.panelOffsetY, 0.25,
                                0.25, 1, true, 0)
                        elseif Config.panelType == "old" then
                            _DrawRect(0.85, 0.91, 0.24, 0.11, 0, 0, 0, 200, 0)

                            if (getVehicleLightStage(GetVehiclePedIsUsing(GetPlayerPed(-1))) == 1) then
                                _DrawRect(0.75, 0.88, 0.03, 0.02, 173, 0, 0, 225, 0)
                                Draw("1", 0, 0, 0, 255, 0.75, 0.87, 0.25, 0.25, 1, true, 0)
                            else
                                _DrawRect(0.75, 0.88, 0.03, 0.02, 186, 186, 186, 225, 0)
                                Draw("1", 0, 0, 0, 255, 0.75, 0.87, 0.25, 0.25, 1, true, 0)
                            end

                            if (getVehicleLightStage(GetVehiclePedIsUsing(GetPlayerPed(-1))) == 2) then
                                _DrawRect(0.784, 0.88, 0.03, 0.02, 173, 0, 0, 225, 0)
                                Draw("2", 0, 0, 0, 255, 0.784, 0.87, 0.25, 0.25, 1, true, 0)
                            else
                                _DrawRect(0.784, 0.88, 0.03, 0.02, 186, 186, 186, 225, 0)
                                Draw("2", 0, 0, 0, 255, 0.784, 0.87, 0.25, 0.25, 1, true, 0)
                            end

                            if (getVehicleLightStage(GetVehiclePedIsUsing(GetPlayerPed(-1))) == 3) then
                                _DrawRect(0.817, 0.88, 0.03, 0.02, 173, 0, 0, 225, 0)
                                Draw("3", 0, 0, 0, 255, 0.817, 0.87, 0.25, 0.25, 1, true, 0)
                            else
                                _DrawRect(0.817, 0.88, 0.03, 0.02, 186, 186, 186, 225, 0)
                                Draw("3", 0, 0, 0, 255, 0.817, 0.87, 0.25, 0.25, 1, true, 0)
                            end

                            _DrawRect(0.854, 0.88, 0.035, 0.02, 186, 186, 186, 225, 0)
                            Draw("PRIM " .. tostring(lightPatternPrim), 0, 0, 0, 255, 0.854, 0.87, 0.25, 0.25, 1, true,
                                0)

                            _DrawRect(0.854, 0.91, 0.035, 0.02, 186, 186, 186, 225, 0)
                            Draw("SEC " .. tostring(lightPatternSec), 0, 0, 0, 255, 0.854, 0.9, 0.25, 0.25, 1, true, 0)

                            if (getVehicleVCFInfo(vehN).secl.type == "traf" or getVehicleVCFInfo(vehN).secl.type ==
                                "chp") then
                                _DrawRect(0.854, 0.94, 0.035, 0.02, 186, 186, 186, 225, 0)
                                Draw("ADV " .. tostring(advisorPatternSelectedIndex), 0, 0, 0, 255, 0.854, 0.93, 0.25,
                                    0.25, 1, true, 0)
                            end

                            if (h_horn_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 1) then
                                _DrawRect(0.75, 0.91, 0.03, 0.02, 0, 173, 0, 225, 0)
                                Draw("HORN", 0, 0, 0, 255, 0.75, 0.9, 0.25, 0.25, 1, true, 0)
                            else
                                _DrawRect(0.75, 0.91, 0.03, 0.02, 186, 186, 186, 225, 0)
                                Draw("HORN", 0, 0, 0, 255, 0.75, 0.9, 0.25, 0.25, 1, true, 0)
                            end

                            if (dualEnable[GetVehiclePedIsUsing(GetPlayerPed(-1))]) then
                                _DrawRect(0.784, 0.91, 0.03, 0.02, 0, 213, 255, 225, 0)
                                Draw("DUAL", 0, 0, 0, 255, 0.784, 0.9, 0.25, 0.25, 1, true, 0)
                            else
                                _DrawRect(0.784, 0.91, 0.03, 0.02, 186, 186, 186, 225, 0)
                                Draw("DUAL", 0, 0, 0, 255, 0.784, 0.9, 0.25, 0.25, 1, true, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 11)) then
                                _DrawRect(0.817, 0.91, 0.03, 0.02, 255, 0, 0, 255, 0)
                                Draw("TKD", 0, 0, 0, 255, 0.817, 0.9, 0.25, 0.25, 1, true, 0)
                            else
                                _DrawRect(0.817, 0.91, 0.03, 0.02, 186, 186, 186, 225, 0)
                                Draw("TKD", 0, 0, 0, 255, 0.817, 0.9, 0.25, 0.25, 1, true, 0)
                            end

                            if (m_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 1) then
                                if (d_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 1) then
                                    _DrawRect(0.743, 0.94, 0.015, 0.02, 0, 173, 0, 225, 0)
                                else
                                    _DrawRect(0.75, 0.94, 0.03, 0.02, 0, 173, 0, 225, 0)
                                end
                            else
                                _DrawRect(0.75, 0.94, 0.03, 0.02, 186, 186, 186, 225, 0)
                            end

                            if (d_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 1) then
                                if (m_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 1) then
                                    _DrawRect(0.758, 0.94, 0.015, 0.02, 0, 213, 255, 225, 2)
                                else
                                    _DrawRect(0.75, 0.94, 0.03, 0.02, 0, 213, 255, 225, 0)
                                end
                            end

                            Draw("MAIN", 0, 0, 0, 255, 0.75, 0.93, 0.25, 0.25, 3, true, 0)

                            if (m_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 2) then
                                if (d_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 2) then
                                    _DrawRect(0.777, 0.94, 0.015, 0.02, 0, 173, 0, 225, 0)
                                else
                                    _DrawRect(0.784, 0.94, 0.03, 0.02, 0, 173, 0, 225, 0)
                                end
                            else
                                _DrawRect(0.784, 0.94, 0.03, 0.02, 186, 186, 186, 225, 0)
                            end

                            if (d_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 2) then
                                if (m_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 2) then
                                    _DrawRect(0.792, 0.94, 0.015, 0.02, 0, 213, 255, 225, 2)
                                else
                                    _DrawRect(0.784, 0.94, 0.03, 0.02, 0, 213, 255, 255, 0)
                                end
                            end

                            Draw("SEC", 0, 0, 0, 255, 0.784, 0.93, 0.25, 0.25, 3, true, 0)

                            if (m_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 3) then
                                if (d_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 3) then
                                    _DrawRect(0.81, 0.94, 0.015, 0.02, 0, 173, 0, 225, 0)
                                else
                                    _DrawRect(0.817, 0.94, 0.03, 0.02, 0, 173, 0, 225, 0)
                                end
                            else
                                _DrawRect(0.817, 0.94, 0.03, 0.02, 186, 186, 186, 225, 0)
                            end

                            if (d_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 3) then
                                if (m_siren_state[GetVehiclePedIsUsing(GetPlayerPed(-1))] == 3) then
                                    _DrawRect(0.823, 0.94, 0.015, 0.02, 0, 213, 255, 225, 2)
                                else
                                    _DrawRect(0.817, 0.94, 0.03, 0.02, 0, 213, 255, 255, 0)
                                end
                            end

                            Draw("AUX", 0, 0, 0, 255, 0.817, 0.93, 0.25, 0.25, 3, true, 0)

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 7)) then
                                _DrawRect(0.9, 0.94, 0.015, 0.015, getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                            else
                                _DrawRect(0.9, 0.94, 0.015, 0.015, 186, 186, 186, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 8)) then
                                _DrawRect(0.92, 0.94, 0.015, 0.015, getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                            else
                                _DrawRect(0.92, 0.94, 0.015, 0.015, 186, 186, 186, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 9)) then
                                _DrawRect(0.94, 0.94, 0.015, 0.015, getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                            else
                                _DrawRect(0.94, 0.94, 0.015, 0.015, 186, 186, 186, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1)) then
                                _DrawRect(0.89, 0.92, 0.015, 0.015, getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                            else
                                _DrawRect(0.89, 0.92, 0.015, 0.015, 186, 186, 186, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 2)) then
                                _DrawRect(0.91, 0.92, 0.015, 0.015, getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                            else
                                _DrawRect(0.91, 0.92, 0.015, 0.015, 186, 186, 186, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 3)) then
                                _DrawRect(0.93, 0.92, 0.015, 0.015, getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                            else
                                _DrawRect(0.93, 0.92, 0.015, 0.015, 186, 186, 186, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 4)) then
                                _DrawRect(0.95, 0.92, 0.015, 0.015, getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                            else
                                _DrawRect(0.95, 0.92, 0.015, 0.015, 186, 186, 186, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 5)) then
                                _DrawRect(0.91, 0.885, 0.015, 0.015, getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                            else
                                _DrawRect(0.91, 0.885, 0.015, 0.015, 186, 186, 186, 225, 0)
                            end

                            if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 6)) then
                                _DrawRect(0.93, 0.885, 0.015, 0.015, getVehicleVCFInfo(vehN).interface.buttonColor.r,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.g,
                                    getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
                            else
                                _DrawRect(0.93, 0.885, 0.015, 0.015, 186, 186, 186, 225, 0)
                            end
                        elseif Config.panelType == "fedsigss" then
                            error(string.format("This panel type (%s) is not supported, yet.", Config.panelType))
                        end
                    end
                end
            end
        end
        Wait(2)
    end
end)

CreateThread(function()
    while true do
        for k, v in pairs(elsVehs) do
            if (v ~= nil or DoesEntityExist(k)) then
                if #(GetEntityCoords(k) - GetEntityCoords(GetPlayerPed(-1))) <= Config.vehicleSyncDistance then
                    if elsVehs[k].warning or elsVehs[k].secondary or elsVehs[k].primary then
                        SetVehicleEngineOn(k, true, true, false)
                    end

                    local vehN = checkCarHash(k)

                    for i = 11, 12 do
                        if (not IsEntityDead(k) and DoesEntityExist(k)) then
                            if (els_Vehicles[vehN] == nil or els_Vehicles[vehN].extras == nil) then
                                debugPrint("Index for current vehicle (" .. vehN .. ") was nil (invalid), returning.",
                                    true, true)
                                return
                            end

                            if (IsVehicleExtraTurnedOn(k, i)) then
                                local boneIndex = GetEntityBoneIndexByName(k, "extra_" .. i)
                                local coords = GetWorldPositionOfEntityBone(k, boneIndex)
                                local rotX, rotY, rotZ = table.unpack(RotAnglesToVec(GetEntityRotation(k, 2)))

                                if els_Vehicles[vehN].extras[i].env_light then
                                    if i == 11 then
                                        DrawSpotLightWithShadow(coords.x + els_Vehicles[vehN].extras[11].env_pos.x,
                                            coords.y + els_Vehicles[vehN].extras[11].env_pos.y,
                                            coords.z + els_Vehicles[vehN].extras[11].env_pos.z, rotX, rotY, rotZ, 255,
                                            255, 255, 75.0, 2.0, 10.0, 20.0, 0.0, true)
                                    end
                                    if i == 12 then
                                        DrawLightWithRange(coords.x + els_Vehicles[vehN].extras[12].env_pos.x,
                                            coords.y + els_Vehicles[vehN].extras[12].env_pos.y,
                                            coords.z + els_Vehicles[vehN].extras[12].env_pos.z, 255, 255, 255, 50.0,
                                            Config.environmentLightBrightness)
                                    end
                                else
                                    if i == 11 then
                                        DrawSpotLightWithShadow(coords.x, coords.y, coords.z + 0.2, rotX, rotY, rotZ,
                                            255, 255, 255, 75.0, 2.0, 10.0, 20.0, 0.0, true)
                                    end
                                    if i == 12 then
                                        DrawLightWithRange(coords.x, coords.y, coords.z, 255, 255, 255, 50.0,
                                            Config.environmentLightBrightness)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Wait(4)
    end
end)

CreateThread(function()
    while true do
        for k, v in pairs(elsVehs) do
            if v ~= nil and DoesEntityExist(k) and #(GetEntityCoords(k) - GetEntityCoords(PlayerPedId())) <=
                Config.vehicleSyncDistance then

                local lastState = lastVehicleStates[k] or {}

                local vcfInfo = getVehicleVCFInfo(k)
                if not vcfInfo then
                    debugPrint("Insufficient VCF information obtained for " .. k .. ", returning.", true, true)
                    goto continue
                end

                if lastState.stage ~= v.stage or lastState.advisorPattern ~= v.advisorPattern or lastState.secPattern ~=
                    v.secPattern or lastState.primPattern ~= v.primPattern or lastState.warning ~= v.warning or
                    lastState.secondary ~= v.secondary or lastState.primary ~= v.primary then
                    lastVehicleStates[k] = {
                        stage = v.stage,
                        advisorPattern = v.advisorPattern,
                        secPattern = v.secPattern,
                        primPattern = v.primPattern,
                        warning = v.warning,
                        secondary = v.secondary,
                        primary = v.primary
                    }

                    SetVehicleAutoRepairDisabled(k, true)

                    if vcfInfo.priml.type == "chp" and vcfInfo.wrnl.type == "chp" and vcfInfo.secl.type == "chp" then

                        if v.stage == 0 then
                            for i = 1, 10 do
                                setExtraState(k, i, 1)
                            end
                        end

                    else

                        if not v.warning then
                            setExtraState(k, 5, 1)
                            setExtraState(k, 6, 1)
                        end

                        if not v.secondary then
                            setExtraState(k, 7, 1)
                            setExtraState(k, 8, 1)
                            setExtraState(k, 9, 1)
                        end

                        if not v.primary then
                            setExtraState(k, 1, 1)
                            setExtraState(k, 2, 1)
                            setExtraState(k, 3, 1)
                            setExtraState(k, 4, 1)
                        end

                    end
                end
            end
            ::continue::
        end

        Citizen.Wait(250)
    end
end)
