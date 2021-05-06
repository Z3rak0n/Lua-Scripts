fx_version 'cerulean'
games { 'gta5' }

author 'Z3rak0n'
description 'AdminSystem'
version '1.0.0'

dependency 'essentialmode'

-- What to run
client_scripts {
    "@NativeUI/NativeUI.lua",
    'Client/client.lua',
    'Config.lua',
    'Client/notify.lua',
    'Client/functions.lua'
}
server_scripts{
'Server/server.lua',
'Config.lua'
} 