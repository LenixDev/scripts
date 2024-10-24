TwoNa = exports["2na_core"]:getSharedObject()

TwoNa.RegisterServerCallback("sgx-banking:Server:GetUserAccounts", function(source, data, cb) 
    local identifier = TwoNa.GetCharacterIdentifier(source)
    local xPlayer = TwoNa.GetPlayer(source)

    local accounts = TwoNa.MySQL.Sync.Fetch("SELECT * FROM accounts WHERE identifier = @id", { ["@id"] = identifier })

    if #accounts == 0 and Config.AutoCreateAccount then 
        local defaultAccount = {
            identifier = identifier,
            id = GenerateAccountId(),
            name = "Personal Account",
            balance = 0,
            transactions = {}
        }

        TwoNa.MySQL.Sync.Execute("INSERT INTO accounts (identifier, id, name, balance, transactions) VALUES (?, ?, ?, ?, ?)", {
            defaultAccount.identifier,
            defaultAccount.id,
            defaultAccount.name,
            defaultAccount.balance,
            json.encode(defaultAccount.transactions)
        })

        cb({playerName = xPlayer.name, accounts = {defaultAccount}})
    else
        for k,v in ipairs(accounts) do 
            accounts[k].transactions = json.decode(v.transactions)
        end

        cb({playerName = xPlayer.name, accounts = accounts})
    end
end)

TwoNa.RegisterServerCallback("sgx-banking:Server:CreateAccount", function(source, data, cb) 
    local identifier = TwoNa.GetCharacterIdentifier(source)

    if not data.accountName then 
        return cb(nil)
    end

    local account = {
        identifier = identifier,
        id = GenerateAccountId(),
        name = data.accountName,
        balance = 0,
        transactions = {}
    }

    TwoNa.MySQL.Sync.Execute("INSERT INTO accounts (identifier, id, name, balance, transactions) VALUES (?, ?, ?, ?, ?)", {
        account.identifier,
        account.id,
        account.name,
        account.balance,
        json.encode(account.transactions)
    })

    cb(account)
end)

TwoNa.RegisterServerCallback("sgx-banking:Server:DeleteAccount", function(source, data, cb) 
    local identifier = TwoNa.GetCharacterIdentifier(source)

    local result = TwoNa.MySQL.Sync.Execute("DELETE FROM accounts WHERE identifier = ? and id = ?", { identifier, data.accountId })

    if result.affectedRows >= 1 then 
        cb(true)
    else
        cb(false)
    end   
end)

TwoNa.RegisterServerCallback("sgx-banking:Server:DepositMoney", function(source, data, cb) 
    local identifier = TwoNa.GetCharacterIdentifier(source)
    local xPlayer = TwoNa.GetPlayer(source)

    if not data.accountId or not xPlayer then 
        return cb(nil)
    end

    local accounts = TwoNa.MySQL.Sync.Fetch("SELECT * FROM accounts WHERE identifier = ? and id = ?", { identifier, data.accountId })

    if accounts[1] and tonumber(data.amount) <= xPlayer.getMoney() then 
        xPlayer.removeMoney(data.amount)

        accounts[1].balance = accounts[1].balance + data.amount
        accounts[1].transactions = json.decode(accounts[1].transactions)
        table.insert(accounts[1].transactions, { type = "deposit", amount = data.amount, description = data.description or nil })

        TwoNa.MySQL.Sync.Execute("UPDATE accounts SET balance = ?, transactions = ? WHERE identifier = ? and id = ?", { accounts[1].balance, json.encode(accounts[1].transactions), identifier, data.accountId })

        accounts[1].playerName = xPlayer.name

        cb({accounts[1]})
    else 
        cb(nil)
    end
end)

TwoNa.RegisterServerCallback("sgx-banking:Server:WithdrawMoney", function(source, data, cb) 
    local identifier = TwoNa.GetCharacterIdentifier(source)
    local xPlayer = TwoNa.GetPlayer(source)

    if not data.accountId or not xPlayer then 
        return cb(nil)
    end

    local accounts = TwoNa.MySQL.Sync.Fetch("SELECT * FROM accounts WHERE identifier = ? and id = ?", { identifier, data.accountId })

    if accounts[1] then 
        if accounts[1].balance >= tonumber(data.amount) then 
            accounts[1].balance = accounts[1].balance - data.amount

            accounts[1].transactions = json.decode(accounts[1].transactions)
            table.insert(accounts[1].transactions, { type = "withdraw", amount = data.amount, description = data.description or nil })

            TwoNa.MySQL.Sync.Execute("UPDATE accounts SET balance = ?, transactions = ? WHERE identifier = ? and id = ?", { accounts[1].balance, json.encode(accounts[1].transactions), identifier, data.accountId })
    
            xPlayer.addMoney(data.amount)

            accounts[1].playerName = xPlayer.name

            cb({accounts[1]})
        else
            cb(nil)
        end
    end
end)

TwoNa.RegisterServerCallback("sgx-banking:Server:TransferMoney", function(source, data, cb) 
    local identifier = TwoNa.GetCharacterIdentifier(source)

    local accountFetch = TwoNa.MySQL.Sync.Fetch("SELECT * FROM accounts WHERE identifier = ? and id = ?", { identifier, data.accountId })

    if accountFetch[1] then 
        local senderAccount = accountFetch[1]

        if senderAccount.balance >= tonumber(data.amount) then 

            local targetAccountFetch = TwoNa.MySQL.Sync.Fetch("SELECT * FROM accounts WHERE id = ?", { data.targetId })

            if targetAccountFetch[1] then
                local targetAccount =targetAccountFetch[1]

                senderAccount.balance = senderAccount.balance - data.amount

                senderAccount.transactions = json.decode(senderAccount.transactions)
                table.insert(senderAccount.transactions, { type = "transfer_sent", amount = data.amount, description = data.description, targetId = data.targetId })

                targetAccount.balance = targetAccount.balance + data.amount

                targetAccount.transactions = json.decode(targetAccount.transactions)
                table.insert(targetAccount.transactions, { type = "transfer_recieved", amount = data.amount, description = data.description, targetId = senderAccount.id })

                TwoNa.MySQL.Sync.Execute("UPDATE accounts SET balance = ?, transactions = ? WHERE id = ?", { senderAccount.balance, json.encode(senderAccount.transactions), senderAccount.id })
                TwoNa.MySQL.Sync.Execute("UPDATE accounts SET balance = ?, transactions = ? WHERE id = ?", { targetAccount.balance, json.encode(targetAccount.transactions), targetAccount.id })

                if targetAccount.identifier == senderAccount.identifier then 
                    cb({ senderAccount, targetAccount })
                else
                    cb({ senderAccount })
                end
            else 
                cb(nil)
            end
                    
        else 
            cb(nil)
        end
    end
end)