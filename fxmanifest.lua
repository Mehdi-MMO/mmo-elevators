fx_version 'cerulean'
game 'gta5'
lua54 'yes'

title "MMO-ELEVATORS"
author "mehdimmo"
version '1.3.0'

client_script 'client.lua'

shared_scripts {
	'@ox_lib/init.lua',
    'config.lua'
}

dependency 'ox_lib'
