function debugPrint(msg, force, inLoop)
    local prefix = IsDuplicityVersion() and '(server)' or '(client)'
    if EGetConvarBool("els_debug") or force then
        print(prefix .. ' ELS-FiveM: ' .. msg)
        if inLoop then
            Citizen.Wait(500)
        end
    end
end

function EGetConvarBool(convar)
    return GetConvar(tostring(convar), "false") == "true"
end

function notify(msg, type)
    type = type or 'inform'

    if Config.Notify == 'ox' then
        if lib and lib.notify then
            lib.notify({
                title = _U('notify'),
                description = msg,
                type = type,
                duration = 3000
            })
        else
            print('[WARN] ox_lib not found – fallback to print')
            print(msg)
        end

    elseif Config.Notify == 'esx' then
        if ESX and ESX.ShowNotification then
            ESX.ShowNotification(msg)
        else
            print('[WARN] ESX not found – fallback to print')
            print(msg)
        end

    else
        print('[INFO] ' .. msg)
    end
end

function string_lower(str)

    if not str or type(str) ~= "string" then

        return

    end

    return string.lower(str)

end

function string_upper(str)

    if not str or type(str) ~= "string" then

        return

    end

    return string.upper(str)

end
