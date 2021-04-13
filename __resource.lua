resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'PRACA EMS KQPIEGO XD'

version '1.0.0'

server_scripts {
  '@es_extended/locale.lua',
  '@mysql-async/lib/MySQL.lua',
  'k_pracaems_config.lua',
  'server/k_pracaems_server.lua'
}

client_scripts {
  '@es_extended/locale.lua',
  'k_pracaems_config.lua',
  'client/k_pracaems_client.lua'
}