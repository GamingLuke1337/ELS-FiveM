if not Config.Update then
    return
end

if lib then
    lib.versionCheck('GamingLuke1337/ELS-FiveM')
else
    print(_U('oxerror'))
end