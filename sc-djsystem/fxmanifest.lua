fx_version 'cerulean'
games { 'gta5' }
lua54 "yes"

client_scripts {
    'config.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'client/client.lua'
}

server_scripts {
    'config.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'server/server.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
}

dependencies {
    'ox_lib',
    'xsound',
}