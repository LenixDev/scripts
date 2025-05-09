Config = {}

Config.Language = "en" -- Language used: "en" for English or "ar" for Arabic

Config.inventory = "qb-inventory" -- Name of the inventory library used
Config.inventoryImage = 'https://cfx-nui-' .. Config.inventory .. '/html/images/%s' -- Path for each item's image in the inventory

Config.Text = {
    en = {
        OpenPawnShop = "Open Pawn Shop", -- Text for opening the pawn shop
        OpenBossMenu = "Open Boss Menu", -- Text for opening the boss menu
        SellItem = "Sell Item", -- Text for selling an item
        BuyItem = "Buy Item", -- Text for buying an item
        ClaimMoney = "Claim Money", -- Text for claiming money
        Exit = "Exit", -- Text for exiting
        NoPendingPayments = "No pending payments", -- Text for no pending payments
        NotEnoughMoney = "You don't have enough money", -- Text for insufficient funds
        ItemListed = "Your item is now listed for sale in the market!", -- Text for item listed for sale
        CannotSellItem = "You cannot sell this item!", -- Text for inability to sell an item
        NotEnoughItemsToSell = "You don't have enough of this item to sell!", -- Text for insufficient items to sell
        NoItemsToSell = "You have no items to sell!", -- Text for no items available for sale
        Amount = "Amount", -- Text for amount
        SelectItemToSell = "Select an Item to Sell", -- Text for selecting an item to sell
        EnterSaleDetails = "Enter Sale Details", -- Text for entering sale details
        AmountToSell = "Amount to Sell", -- Text for amount to sell
        PricePerItem = "Price per Item", -- Text for price per item
        NoItemsForSale = "There are no items for sale at the moment", -- Text for no items for sale
        BuyItemsFromPawnShop = "Buy Items from Pawn Shop", -- Text for buying items from the pawn shop
        ConfirmPurchase = "Confirm Purchase", -- Text for confirming purchase
        HowManyToBuy = "How many would you like to buy?", -- Text for asking quantity to buy
        ItemNotAvailable = "This item is no longer available", -- Text for unavailable item
        NotEnoughItemsInStock = "Not enough items in stock", -- Text for insufficient stock
        ItemSold = "You bought %d x %s for $%s", -- Text for successful item purchase
        ClaimAll = "Claim All Money", -- Text for claiming all money
        ClaimAllMoneyAfterTax = "Claim all pending money after tax.", -- Text for claiming money after tax
        ClaimPendingMoney = "Claim Pending Money", -- Text for claiming pending money
        Claim = "Claim", -- Text for claim action
        For = "for", -- Text for "for"
        Price = "Price", -- Text for price
        successfully = "successfully", -- Text for success message
    },
    ar = {
        OpenPawnShop = "فتح متجر ", -- Arabic text for opening the pawn shop
        OpenBossMenu = "فتح قائمة المدير", -- Arabic text for opening the boss menu
        SellItem = "بيع العنصر", -- Arabic text for selling an item
        BuyItem = "شراء العنصر", -- Arabic text for buying an item
        ClaimMoney = "استلام المال", -- Arabic text for claiming money
        Exit = "خروج", -- Arabic text for exiting
        NoPendingPayments = "لا توجد مدفوعات مستحقة", -- Arabic text for no pending payments
        NotEnoughMoney = "ليس لديك ما يكفي من المال", -- Arabic text for insufficient funds
        ItemListed = "تم إدراج عنصر الخاص بك في السوق!", -- Arabic text for item listed for sale
        CannotSellItem = "لا يمكنك بيع هذا العنصر!", -- Arabic text for inability to sell an item
        NotEnoughItemsToSell = "ليس لديك ما يكفي من هذا العنصر لبيعه!", -- Arabic text for insufficient items to sell
        NoItemsToSell = "ليس لديك عناصر للبيع!", -- Arabic text for no items available for sale
        Amount = "الكمية", -- Arabic text for amount
        SelectItemToSell = "اختر عنصرًا لبيعه", -- Arabic text for selecting an item to sell
        EnterSaleDetails = "أدخل تفاصيل البيع", -- Arabic text for entering sale details
        AmountToSell = "الكمية المراد بيعها", -- Arabic text for amount to sell
        PricePerItem = "سعر لكل عنصر", -- Arabic text for price per item
        NoItemsForSale = "لا توجد عناصر للبيع في الوقت الحالي", -- Arabic text for no items for sale
        BuyItemsFromPawnShop = "شراء العناصر من متجر الرهونات", -- Arabic text for buying items from the pawn shop
        ConfirmPurchase = "تأكيد الشراء", -- Arabic text for confirming purchase
        HowManyToBuy = "كم عدد العناصر التي تود شرائها؟", -- Arabic text for asking quantity to buy
        ItemNotAvailable = "هذا العنصر لم يعد متاحًا", -- Arabic text for unavailable item
        NotEnoughItemsInStock = "لا توجد كمية كافية في المخزون", -- Arabic text for insufficient stock
        ItemSold = "لقد اشتريت %d من %s مقابل $%s", -- Arabic text for successful item purchase
        ClaimAll = "استلام كل المال", -- Arabic text for claiming all money
        ClaimAllMoneyAfterTax = "استلام كل المال المستحق بعد الضريبة.", -- Arabic text for claiming money after tax
        ClaimPendingMoney = "استلام المال المستحق", -- Arabic text for claiming pending money
        Claim = "استلام", -- Arabic text for claim action
        For = "لـ", -- Arabic text for "for"
        Price = "السعر", -- Arabic text for price
        successfully = "بنجاح", -- Arabic text for success message
    }
}

Config.items = {} -- Table to store items (do not modify)
Config.Core = "qb-core" -- Name of the core framework used
Config.EnableReturn = true -- Specify whether to return items
Config.TaxSystem = 0.25 -- Tax rate for transactions

Config.Discord = {
    ['webhook'] = 'YOUR_DISCORD_WEBHOOK_URL_HERE', -- Discord webhook URL
    ['name'] = 'Pawn Shop', -- Discord username
    ['image'] = 'YOUR_DISCORD_IMAGE_URL_HERE' -- Discord user image
}

Config.BossMenuEvent = "qb-bossmenu:server:openMenu" -- Event name to call for opening the boss menu

Config.BossMenu = {
    account = 'pawnshop', -- Account name for the boss
    taxEvent = 'qb-bossmenu:server:addAccountMoney', -- Event to add money to the boss account
    taxRate = 0.25 -- Tax rate for the boss
}

Config.Job = {
    ["pawnshop"] = 0 -- Table containing available jobs
}

Config.Blips = {
    coords = vector3(173.29, -1317.0, 28.35), -- Blip coordinates
    sprite = 779, -- Blip sprite ID
    display = 4, -- Blip display type
    scale = 0.6, -- Blip scale
    color = 5, -- Blip color
    short = true, -- Specify if the blip is short
    name = "Pawn Shop" -- Blip name
}

Config.Ped = {
    model = "a_m_m_indian_01", -- Ped model
    coords = vector4(-1371.39, -625.86, 30.82, 118.58), -- Ped coordinates
    scenario = "WORLD_HUMAN_CLIPBOARD", -- Interaction scenario
    interactDist = 2.0, -- Interaction distance
    ignoreLOS = true, -- Ignore line of sight
    offset = vec3(0.0, 0.0, 0.3), -- Interaction offset
}

Config.Target = {
    type = "qb-target", -- Target type
}

Config.BlacklistItem = {
    ["joint"] = true, -- Blacklisted items
}
