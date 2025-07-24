function runEnvironmentLight(k, extra)
    CreateThread(function()
        if not IsEntityDead(k) and k ~= nil then
            local vehN = checkCarHash(k)

            if els_Vehicles[vehN].extras[extra] ~= nil then
                if (els_Vehicles[vehN].extras[extra].env_light) then
                    local boneIndex = GetEntityBoneIndexByName(k, "extra_" .. extra)
                    local coords = GetWorldPositionOfEntityBone(k, boneIndex)

                    for _ = 1, 6 do
                        if (IsVehicleExtraTurnedOn(k, extra) == false) then
                            break
                        end
                        DrawLightWithRangeAndShadow(coords.x + els_Vehicles[vehN].extras[extra].env_pos.x,
                            coords.y + els_Vehicles[vehN].extras[extra].env_pos.y,
                            coords.z + els_Vehicles[vehN].extras[extra].env_pos.z,
                            els_Vehicles[vehN].extras[extra].env_color.r, els_Vehicles[vehN].extras[extra].env_color.g,
                            els_Vehicles[vehN].extras[extra].env_color.b, 50.0, Config.environmentLightBrightness, 5.0)
                        -- DrawLightWithRange(coords.x + els_Vehicles[vehN].extras[extra].env_pos.x, coords.y + els_Vehicles[vehN].extras[extra].env_pos.y, coords.z + els_Vehicles[vehN].extras[extra].env_pos.z, els_Vehicles[vehN].extras[extra].env_color.r, els_Vehicles[vehN].extras[extra].env_color.g, els_Vehicles[vehN].extras[extra].env_color.b, 150 + 0.0, Config.environmentLightBrightness)
                        Wait(2)
                    end
                end
            end
        end
    end)
end

local chpPatternReady = {}
function runCHPPattern(k, pattern, stage)
    CreateThread(function()
        if (not IsEntityDead(k) and DoesEntityExist(k) and (chpPatternReady[k] or chpPatternReady[k] == nil)) then

            chpPatternReady[k] = false

            local done = {}
            for i = 1, 10 do
                done[i] = false
            end

            if stage == 1 then
                CreateThread(function()
                    for spot = 1, string.len(chp_StageOne[pattern][1]) do
                        local c = tonumber(string.sub(chp_StageOne[pattern][1], spot, spot))
                        setExtraState(k, 1, c)
                        if c == 0 then
                            runEnvironmentLight(k, 1)
                        end

                        if elsVehs[k].advisorPattern ~= pattern then
                            done[1] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageOne[pattern][1]) then
                            done[1] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageOne[pattern][2]) do
                        local c = tonumber(string.sub(chp_StageOne[pattern][2], spot, spot))
                        setExtraState(k, 2, c)
                        if c == 0 then
                            runEnvironmentLight(k, 2)
                        end

                        if elsVehs[k].advisorPattern ~= pattern then
                            done[2] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageOne[pattern][2]) then
                            done[2] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageOne[pattern][3]) do
                        local c = tonumber(string.sub(chp_StageOne[pattern][3], spot, spot))
                        setExtraState(k, 3, c)
                        if c == 0 then
                            runEnvironmentLight(k, 3)
                        end

                        if elsVehs[k].advisorPattern ~= pattern then
                            done[3] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageOne[pattern][3]) then
                            done[3] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageOne[pattern][4]) do
                        local c = tonumber(string.sub(chp_StageOne[pattern][4], spot, spot))
                        setExtraState(k, 4, c)
                        if c == 0 then
                            runEnvironmentLight(k, 4)
                        end

                        if elsVehs[k].advisorPattern ~= pattern then
                            done[4] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageOne[pattern][4]) then
                            done[4] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageOne[pattern][5]) do
                        local c = tonumber(string.sub(chp_StageOne[pattern][5], spot, spot))
                        setExtraState(k, 5, c)
                        if c == 0 then
                            runEnvironmentLight(k, 5)
                        end

                        if elsVehs[k].advisorPattern ~= pattern then
                            done[5] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageOne[pattern][5]) then
                            done[5] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageOne[pattern][6]) do
                        local c = tonumber(string.sub(chp_StageOne[pattern][6], spot, spot))
                        setExtraState(k, 6, c)
                        if c == 0 then
                            runEnvironmentLight(k, 6)
                        end

                        if elsVehs[k].advisorPattern ~= pattern then
                            done[6] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageOne[pattern][6]) then
                            done[6] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageOne[pattern][7]) do
                        local c = tonumber(string.sub(chp_StageOne[pattern][7], spot, spot))
                        setExtraState(k, 7, c)
                        if c == 0 then
                            runEnvironmentLight(k, 7)
                        end

                        if elsVehs[k].advisorPattern ~= pattern then
                            done[7] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageOne[pattern][7]) then
                            done[7] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageOne[pattern][8]) do
                        local c = tonumber(string.sub(chp_StageOne[pattern][8], spot, spot))
                        setExtraState(k, 8, c)
                        if c == 0 then
                            runEnvironmentLight(k, 8)
                        end

                        if elsVehs[k].advisorPattern ~= pattern then
                            done[8] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageOne[pattern][8]) then
                            done[8] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageOne[pattern][9]) do
                        local c = tonumber(string.sub(chp_StageOne[pattern][9], spot, spot))
                        setExtraState(k, 9, c)
                        if c == 0 then
                            runEnvironmentLight(k, 9)
                        end

                        if elsVehs[k].advisorPattern ~= pattern then
                            done[9] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageOne[pattern][9]) then
                            done[9] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageOne[pattern][10]) do
                        local c = tonumber(string.sub(chp_StageOne[pattern][10], spot, spot))
                        setExtraState(k, 10, c)
                        if c == 0 then
                            runEnvironmentLight(k, 10)
                        end

                        if elsVehs[k].advisorPattern ~= pattern then
                            done[10] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageOne[pattern][10]) then
                            done[10] = true
                            break
                        end
                    end

                    return
                end)
            elseif stage == 2 then
                CreateThread(function()
                    for spot = 1, string.len(chp_StageTwo[pattern][1]) do
                        local c = tonumber(string.sub(chp_StageTwo[pattern][1], spot, spot))
                        setExtraState(k, 1, c)
                        if c == 0 then
                            runEnvironmentLight(k, 1)
                        end

                        if elsVehs[k].secPattern ~= pattern then
                            done[1] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageTwo[pattern][1]) then
                            done[1] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageTwo[pattern][2]) do
                        local c = tonumber(string.sub(chp_StageTwo[pattern][2], spot, spot))
                        setExtraState(k, 2, c)
                        if c == 0 then
                            runEnvironmentLight(k, 2)
                        end

                        if elsVehs[k].secPattern ~= pattern then
                            done[2] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageTwo[pattern][2]) then
                            done[2] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageTwo[pattern][3]) do
                        local c = tonumber(string.sub(chp_StageTwo[pattern][3], spot, spot))
                        setExtraState(k, 3, c)
                        if c == 0 then
                            runEnvironmentLight(k, 3)
                        end

                        if elsVehs[k].secPattern ~= pattern then
                            done[3] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageTwo[pattern][3]) then
                            done[3] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageTwo[pattern][4]) do
                        local c = tonumber(string.sub(chp_StageTwo[pattern][4], spot, spot))
                        setExtraState(k, 4, c)
                        if c == 0 then
                            runEnvironmentLight(k, 4)
                        end

                        if elsVehs[k].secPattern ~= pattern then
                            done[4] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageTwo[pattern][4]) then
                            done[4] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageTwo[pattern][5]) do
                        local c = tonumber(string.sub(chp_StageTwo[pattern][5], spot, spot))
                        setExtraState(k, 5, c)
                        if c == 0 then
                            runEnvironmentLight(k, 5)
                        end

                        if elsVehs[k].secPattern ~= pattern then
                            done[5] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageTwo[pattern][5]) then
                            done[5] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageTwo[pattern][6]) do
                        local c = tonumber(string.sub(chp_StageTwo[pattern][6], spot, spot))
                        setExtraState(k, 6, c)
                        if c == 0 then
                            runEnvironmentLight(k, 6)
                        end

                        if elsVehs[k].secPattern ~= pattern then
                            done[6] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageTwo[pattern][6]) then
                            done[6] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageTwo[pattern][7]) do
                        local c = tonumber(string.sub(chp_StageTwo[pattern][7], spot, spot))
                        setExtraState(k, 7, c)
                        if c == 0 then
                            runEnvironmentLight(k, 7)
                        end

                        if elsVehs[k].secPattern ~= pattern then
                            done[7] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageTwo[pattern][7]) then
                            done[7] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageTwo[pattern][8]) do
                        local c = tonumber(string.sub(chp_StageTwo[pattern][8], spot, spot))
                        setExtraState(k, 8, c)
                        if c == 0 then
                            runEnvironmentLight(k, 8)
                        end

                        if elsVehs[k].secPattern ~= pattern then
                            done[8] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageTwo[pattern][8]) then
                            done[8] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageTwo[pattern][9]) do
                        local c = tonumber(string.sub(chp_StageTwo[pattern][9], spot, spot))
                        setExtraState(k, 9, c)
                        if c == 0 then
                            runEnvironmentLight(k, 9)
                        end

                        if elsVehs[k].secPattern ~= pattern then
                            done[9] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageTwo[pattern][9]) then
                            done[9] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageTwo[pattern][10]) do
                        local c = tonumber(string.sub(chp_StageTwo[pattern][10], spot, spot))
                        setExtraState(k, 10, c)
                        if c == 0 then
                            runEnvironmentLight(k, 10)
                        end

                        if elsVehs[k].secPattern ~= pattern then
                            done[10] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageTwo[pattern][10]) then
                            done[10] = true
                            break
                        end
                    end

                    return
                end)
            elseif stage == 3 then
                CreateThread(function()
                    for spot = 1, string.len(chp_StageThree[pattern][1]) do
                        local c = tonumber(string.sub(chp_StageThree[pattern][1], spot, spot))
                        setExtraState(k, 1, c)
                        if c == 0 then
                            runEnvironmentLight(k, 1)
                        end

                        if elsVehs[k].primPattern ~= pattern then
                            done[1] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageThree[pattern][1]) then
                            done[1] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageThree[pattern][2]) do
                        local c = tonumber(string.sub(chp_StageThree[pattern][2], spot, spot))
                        setExtraState(k, 2, c)
                        if c == 0 then
                            runEnvironmentLight(k, 2)
                        end

                        if elsVehs[k].primPattern ~= pattern then
                            done[2] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageThree[pattern][2]) then
                            done[2] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageThree[pattern][3]) do
                        local c = tonumber(string.sub(chp_StageThree[pattern][3], spot, spot))
                        setExtraState(k, 3, c)
                        if c == 0 then
                            runEnvironmentLight(k, 3)
                        end

                        if elsVehs[k].primPattern ~= pattern then
                            done[3] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageThree[pattern][3]) then
                            done[3] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageThree[pattern][4]) do
                        local c = tonumber(string.sub(chp_StageThree[pattern][4], spot, spot))
                        setExtraState(k, 4, c)
                        if c == 0 then
                            runEnvironmentLight(k, 4)
                        end

                        if elsVehs[k].primPattern ~= pattern then
                            done[4] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageThree[pattern][4]) then
                            done[4] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageThree[pattern][5]) do
                        local c = tonumber(string.sub(chp_StageThree[pattern][5], spot, spot))
                        setExtraState(k, 5, c)
                        if c == 0 then
                            runEnvironmentLight(k, 5)
                        end

                        if elsVehs[k].primPattern ~= pattern then
                            done[5] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageThree[pattern][5]) then
                            done[5] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageThree[pattern][6]) do
                        local c = tonumber(string.sub(chp_StageThree[pattern][6], spot, spot))
                        setExtraState(k, 6, c)
                        if c == 0 then
                            runEnvironmentLight(k, 6)
                        end

                        if elsVehs[k].primPattern ~= pattern then
                            done[6] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageThree[pattern][6]) then
                            done[6] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageThree[pattern][7]) do
                        local c = tonumber(string.sub(chp_StageThree[pattern][7], spot, spot))
                        setExtraState(k, 7, c)
                        if c == 0 then
                            runEnvironmentLight(k, 7)
                        end

                        if elsVehs[k].primPattern ~= pattern then
                            done[7] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageThree[pattern][7]) then
                            done[7] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageThree[pattern][8]) do
                        local c = tonumber(string.sub(chp_StageThree[pattern][8], spot, spot))
                        setExtraState(k, 8, c)
                        if c == 0 then
                            runEnvironmentLight(k, 8)
                        end

                        if elsVehs[k].primPattern ~= pattern then
                            done[8] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageThree[pattern][8]) then
                            done[8] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageThree[pattern][9]) do
                        local c = tonumber(string.sub(chp_StageThree[pattern][9], spot, spot))
                        setExtraState(k, 9, c)
                        if c == 0 then
                            runEnvironmentLight(k, 9)
                        end

                        if elsVehs[k].primPattern ~= pattern then
                            done[9] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageThree[pattern][9]) then
                            done[9] = true
                            break
                        end
                    end

                    return
                end)

                CreateThread(function()
                    for spot = 1, string.len(chp_StageThree[pattern][10]) do
                        local c = tonumber(string.sub(chp_StageThree[pattern][10], spot, spot))
                        setExtraState(k, 10, c)
                        if c == 0 then
                            runEnvironmentLight(k, 10)
                        end

                        if elsVehs[k].primPattern ~= pattern then
                            done[10] = true
                            break
                        end

                        Wait(Config.lightDelay)

                        if spot == string.len(chp_StageThree[pattern][10]) then
                            done[10] = true
                            break
                        end
                    end

                    return
                end)
            end

            while (not done[1] or not done[2] or not done[3] or not done[4] or not done[5] or not done[6] or not done[7] or
                not done[8] or not done[9] or not done[10]) do
                Wait(0)
            end
            if done[1] and done[2] and done[3] and done[4] and done[5] and done[6] and done[7] and done[8] and done[9] and
                done[10] then
                chpPatternReady[k] = true
            end
        end
    end)
end
