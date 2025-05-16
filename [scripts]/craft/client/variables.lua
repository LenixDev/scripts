Koci                       = {}
Koci.ResmonLib             = Utils.Functions:GetResmonLib()
Koci.Framework             = Utils.Functions:GetFramework()
Koci.Utils                 = Utils.Functions
Koci.Utils.CustomInventory = Utils.CustomInventory
Koci.Callbacks             = {}
Koci.Client                = {
    Craft = {
        createdShopBlips = {},
        createdShopBenchObjects = {},
        openedShop = nil,
        isTheShopOpen = false,
        shopCam = nil,
        createdWeaponObjectOnTable = nil,
        selectedWeapon = nil,
        createdItemObjectOnTable = nil,
        CraftingQueues = {},
        completedCraftingQueues = {},
        queueThreadIsActive = false
    },
}
