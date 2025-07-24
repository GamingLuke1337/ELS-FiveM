fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'Pinguin aka. GamingLuke1337'
description 'A resource which provides extensive controls for Emergency Lighting System-V created by Lt.Caine'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/main.lua'
}

client_scripts {
    'vcf.lua',
    'config.lua',
    'client/main.lua',
    'client/patterns.lua',
    'client/utils.lua'
}

server_scripts {
    'vcf.lua',
    'config.lua',
    'server/main.lua',
    'server/update.lua',
    'server/xml.lua'
}
