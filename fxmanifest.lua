fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'zf-policejob'
author 'Virella.scripts'
description 'Zero Frame Police Job (qbx_core, ox_lib radial/context, zf-notify, qbx_vehiclekeys)'
version '1.0.0'

dependencies {
    'qbx_core',
    'ox_lib',
    'zf-notify'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}
