-- 1) Add these items to the items.lua in qb-core shared (translate them)

["spray"] 					 	 = {["name"] = "spray", 			  	  		["label"] = "Bomboletta Spray", 		["weight"] = 300, 		["type"] = "item", 		["image"] = "spray.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Una bomboletta spray di vernice"},
["spray_remover"] 			     = {["name"] = "spray_remover", 			  	["label"] = "Kit rimozione Spray", 		["weight"] = 300, 		["type"] = "item", 		["image"] = "spray_remover.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Un kit di rimozione vernice spray"},

-- 2) Add the images you'll find in the folder "items images" to qb-inventory>html>images

-- 3) Execute the SQL Query

-- 4) you can edit QB notifications in server>remove.lua to translate them

-- 5) once you did everything, you can delete this file and the folder "items images"