fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'Pinguin aka. GamingLuke1337'
description 'A resource which provides extensive controls for Emergency Lighting System-V created by Lt.Caine'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua'
}

client_script {
    'vcf.lua',
    'config.lua',
    'client/**/*.lua'
}

server_script {
    'vcf.lua',
    'config.lua',
    'server/**/*.lua'
}
