RegisterKeyMapping("+bank", "Shows bank menu", "KEYBOARD", Config.ShowMenuKey)
RegisterCommand("+bank", function() 
    TriggerEvent("sgx-banking:Client:BankMenu:Show")
end)