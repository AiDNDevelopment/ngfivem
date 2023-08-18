fx_version 'adamant'
game 'gta5'

client_scripts{
    'client/client.lua',
    'client/client_processing.lua',
    'client/client_meth.lua',
}

server_scripts{
    'server/server.lua',
    'server/server_processing.lua',
    'server/server_meth.lua',
}

dependencies{
    'qb-core',
    'oxmysql'
}