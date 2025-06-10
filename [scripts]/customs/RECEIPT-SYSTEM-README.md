
### CUSTOMS REWORK | RECEIPTS SYSTEM ###

**YOU CAN DISABLE SERVER CONSOLE PRINT IN THE CONFIG FILE (Config.DisablePrintSupportMessage)**
**YOU CAN DISABLE SERVER CONSOLE PRINT IN THE CONFIG FILE (Config.DisablePrintSupportMessage)**

Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 


⚠️⚠️**FOR RECEIPT SYSTEM PLEASE CHECK `shared/locations.lua` there you can find some settings that you can chnage for the receipt system**⚠️⚠️ - `https://imgur.com/a/ED5gMLC`


### INSTALL ###

1.) Drag and drop `customs` into your server resources.
2.) Add `customs` to your `server.cfg`. --- `ensure customs`
3.) Customize `shared/locations.lua` to your liking, support can be provided if needed. - `https://imgur.com/a/ED5gMLC`, 
4.) Add information provided into your `qb-core/shared.lua` or `qb-core/shared/items.lua`.
5.) Add image provided into your `qb-inventory/html/images`.
### LJ-INVENTORY 
6.) If you are using lj-inventory, go to style.css file **lj-inventory/html/css/main.css** and find `.ply-iteminfo-container` and set max-height to **50%** `max-height: 50%;`. 
`https://imgur.com/a/OThxUHx`
**YOU CAN DISABLE SERVER CONSOLE PRINT IN THE CONFIG FILE (Config.DisablePrintSupportMessage)**
**YOU CAN DISABLE SERVER CONSOLE PRINT IN THE CONFIG FILE (Config.DisablePrintSupportMessage)**


### REQUIREMENTS ###
* [QBCore Framework](https://github.com/qbcore-framework)


### qb-inventory/html/js/app.js at 'FormatItemInfo(itemData) 
`https://imgur.com/a/Lqq8A6q`

```js 

else if (itemData.name == "customs_receipt") {
            $(".item-info-title").html("<p>" + itemData.label + "</p>");
            $(".item-info-description").html(
                "<p><strong>Primary Color: </strong><span>" +
                itemData.info.primaryColor +
                "<p><strong>Secondary Color: </strong><span>" +
                itemData.info.secondaryColor +
                "<p><strong>Pearlescent Color: </strong><span>" +
                itemData.info.pearlescentColour +
                "</span></p><p><strong>Wheel Model: </strong><span>" +
                itemData.info.wheelName +
                "</span></p><p><strong>Wheel Color: </strong><span>" +
                itemData.info.wheelColor +
                "</span></p><p><strong>Wheel Smoke Color: </strong><span>" +
                itemData.info.wheelSmokeColor +
                "</span></p><p><strong>Dashboard Color: </strong><span>" +
                itemData.info.dashboardColor +
                "</span></p><p><strong>Interior Color: </strong><span>" +
                itemData.info.interiorColor +
                "</span></p><p><strong>Neon: </strong><span>" +
                itemData.info.neonColor +
                "</span></p><p><strong>Xenon: </strong><span>" +
                itemData.info.xenonColor +
                "</span></p><p><strong>Window tint: </strong><span>" +
                itemData.info.windowTint +
                "</span></p><p><strong>Cosmetics: </strong><span>" +
                itemData.info.vehicleCosmetics +
                "</span></p>"
            );
    
```


### qb-core/shared/items.lua
```lua
    	-- cuSTOMS -- REWORK  
	['customs_receipt'] 	 	 = {['name'] = 'customs_receipt',		['label'] = 'Receipt', ['weight'] = 10, 			['type'] = 'item', 		['image'] = 'customs_receipt.png', ['unique'] = true, 	['useable'] = false, 	['shouldClose'] = false,	   ['combinable'] = nil,   ['description'] = ''},

``` 
 



Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 
Please note that there is no longer any support for this script, so it will be used at your own discretion and risk. 


**YOU CAN DISABLE SERVER CONSOLE PRINT IN THE CONFIG FILE (Config.DisablePrintSupportMessage)**
**YOU CAN DISABLE SERVER CONSOLE PRINT IN THE CONFIG FILE (Config.DisablePrintSupportMessage)**