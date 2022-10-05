fx_version 'cerulean'
game 'gta5'
description 'Gang stash'
version '1.0.0'
author 'Ares#3333 & Proportions#8460' 

shared_scripts {
    'shared/*.lua',
    '@qb-core/shared/locale.lua',
    'locales/*.lua',
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}