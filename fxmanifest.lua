fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'Pinguin aka. GamingLuke1337'
description 'A resource which provides extensive controls for Emergency Lighting System-V created by Lt.Caine'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/main.lua',
    'config.lua',
    'vcf.lua',
    'lang/*.lua'
}

client_scripts {
    'patterntypes/*.lua',
    'client/main.lua',
    'client/patterns.lua',
    'client/utils.lua'
}

server_scripts {
    'server/main.lua',
    'server/update.lua',
    'server/xml.lua'
}

dependency 'ox_lib'