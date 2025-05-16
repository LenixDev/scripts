### Script

- Hello, first of all thank you for purchasing our plugin :)
- Fivem ESX & QB Craft and Weapon Attachment Script
- Requirements: "0r-lib". Please remember to install the requirements on your server.
- In the server.cfg file, you must start 0r-lib before 0r-craft.
- Please check the locales folder for language translations.
- Don't forget to check the configuration file. "shared/config.lua"
- Don't forget to run the database file. "database.sql"
- Make sure that you add the items specified in Config to your server.
- Make sure that these items correspond to the components system in the inventory script you are using
- ox_inventory and qb-inventory configurations are set.
  For other scripts you should browse to shared/utils.lua and fill in those functions.
- After making the necessary config, upload the script to your server and start it.
- Feel free to contact us with any problem/question. - 0Resmon -

### About the Configuration File

- You can create or edit as many "crafting tables" as you want with the "Config.CraftingTables" variable.
- If you do not know "Config.WeaponAttachment", do not change this value.
- You can configure the components of the weapons you specify in the "Config.Weapons" variable. The "item" value is the value that controls your inventory and that item. This item must be available on your server. The "type" value ensures that the item is added correctly according to the component type. "hash" value
  I do not recommend changing it, it was prepared by checking the GTA wiki.
- You can set your craftable items that can be crafted with the "Config.CraftableItems" value. There it is written in detail which value does what. Please make sure that the "key" value and the "name" value are the same.