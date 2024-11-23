Made By Venom:https://discord.gg/jRaJ8Mca
Made By Venom:https://discord.gg/jRaJ8Mca
Made By Venom:https://discord.gg/jRaJ8Mca
Made By Venom:https://discord.gg/jRaJ8Mca
Made By Venom:https://discord.gg/jRaJ8Mca



1 - ادخل qb-core/shred/items.lua
ركب هذا الايتم مع الصوره

	['venomkey'] = {
		['name'] = 'venomkey',
		['label'] = 'Hotel Key',
		['weight'] = 1,
		['type'] = 'item',
		['image'] = 'key1.png',
		['unique'] = true,
		['useable'] = true,
		['shouldClose'] = false,
		['combinable'] = nil,
		['description'] = ''
	},

2 - ادخل ملف qb-inventory/html/js/app.js
وابحث عن
itemData.name ==
وحط هذا الكود نفس كذا
https://prnt.sc/wl6Xf7PXGz-J

        } else if (itemData.name == "venomkey") {
            $(".item-info-title").html("<p>" + itemData.label + "</p>");
            $(".item-info-description").html("<p>Room Number: #" + itemData.info.roomnumber + "</p>");

3 - عدل على ملف ال shared

4 - انسخ ملف venomhotel.lua
وحطه هنا qb-doorlock/configs

5- ركب الماب

6 - venom-hotel/shared/config.lua لا تنسى تشوف ملف 
