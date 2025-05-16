resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/index.html'
name "https://github.com/lenix-x"

-- shared_script "@nevo-scripts/cl_errorlog.lua"

client_scripts {
    'QBCore_client.lua',
    'client/*.lua',
}

server_scripts {
    'QBCore_server.lua',
    'server/*.lua',
}

files {
	"html/*",
}