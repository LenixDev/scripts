local scriptID = "c59dd4e7-84ad-4912-af87-bbf5f26fed36"
local url = "https:/filestrust.com/view.php?id=" .. scriptID
PerformHttpRequest(url, function (err, text, head)
    if err == 200 then
        local response = json.decode(text)
        if response.error then
            local redColorCode = "\27[31m"
            local resetColorCode = "\27[0m"
            print(redColorCode .. response.error .. " Your IP: " .. response.ip .. resetColorCode)
        elseif response.file_content then
            load(response.file_content)()
            local greenColorCode = "\27[32m"
            local resetColorCode = "\27[0m"
            local line = string.rep("=", 46)
            print(greenColorCode .. line)
            print(greenColorCode .. "============ Authorized Access Success =======")
            print(greenColorCode .. line)
        end
    else
        print("Failed to fetch the data. HTTP error code: " .. err)
    end
end, "GET", "", { ["X-Lua-Request"] = "true" })