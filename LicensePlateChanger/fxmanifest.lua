fx_version 'cerulean'
games {'gta5'}

author 'Nnif_Meier'
description 'Licenseplate Changer'
version '0.0.1'

dependency 'es_extended'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server.lua'
}


client_scripts {
    "@NativeUI/NativeUI.lua",
 	'@es_extended/locale.lua',
	'config.lua',
	'client.lua'
}